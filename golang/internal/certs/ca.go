package main

import (
	"bytes"
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"crypto/x509/pkix"
	"encoding/base64"
	"encoding/pem"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"math/big"
	"strings"
	"time"
)

// flags that the resolver will be passed
var (
	stampInfoFile     = flag.String("stamp-info-file", "", "One or more Bazel stamp info files.")
	imgChroot         = flag.String("image_chroot", "", "The repository under which to chroot image references when publishing them.")
	templateFile      = flag.String("template", "", "The k8s YAML template file to resolve.")
	substitutionsFile = flag.String("substitutions", "", "A file with a list of substitutions that were made in the YAML template. Any stamp values that appear are stamped by the resolver.")
)

func main() {
	flag.Parse()
	ca, caKey, err := setupCA()
	if err != nil {
		log.Fatal("Failed to set up CA:", err)
	}

	crt := base64.StdEncoding.EncodeToString([]byte(ca))
	key := base64.StdEncoding.EncodeToString([]byte(caKey))

	template := readTemplate(*templateFile)
	crtReplaced := strings.Replace(template, "CRT", crt, -1)
	keyReplaced := strings.Replace(crtReplaced, "KEY", key, -1)
	fmt.Print(keyReplaced)
}

func readTemplate(templateFile string) string {
	content, err := ioutil.ReadFile(templateFile)
	if err != nil {
		log.Fatalf("unable to open template file %s: %v", templateFile, err)
	}
	return string(content)
}

func setupCA() (string, string, error) {
	ca := &x509.Certificate{
		SerialNumber: big.NewInt(2019),
		Subject: pkix.Name{
			Country:       []string{"US"},
			Province:      []string{"California"},
			Locality:      []string{"San Francisco"},
			StreetAddress: []string{"Golden Gate Bridge"},
			PostalCode:    []string{"94016"},
		},
		NotBefore:             time.Now(),
		NotAfter:              time.Now().AddDate(10, 0, 0),
		IsCA:                  true,
		ExtKeyUsage:           []x509.ExtKeyUsage{x509.ExtKeyUsageClientAuth, x509.ExtKeyUsageServerAuth},
		KeyUsage:              x509.KeyUsageDigitalSignature | x509.KeyUsageCertSign,
		BasicConstraintsValid: true,
	}

	// create the private and public key
	caPrivKey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		return "", "", err
	}

	// create the CA
	caBytes, err := x509.CreateCertificate(rand.Reader, ca, ca, &caPrivKey.PublicKey, caPrivKey)
	if err != nil {
		return "", "", err
	}

	// pem encode
	caPEM := new(bytes.Buffer)
	pem.Encode(caPEM, &pem.Block{
		Type:  "CERTIFICATE",
		Bytes: caBytes,
	})

	caPrivKeyPEM := new(bytes.Buffer)
	pem.Encode(caPrivKeyPEM, &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: x509.MarshalPKCS1PrivateKey(caPrivKey),
	})

	return caPEM.String(), caPrivKeyPEM.String(), nil
}
