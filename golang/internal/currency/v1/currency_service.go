package v1

import (
	"context"

	pb "github.com/veganafro/mono/golang/pkg/currency/v1"
)

type CurrencyService struct {
	pb.UnimplementedCurrencyServiceServer
}

func (service *CurrencyService) GetUserCurrencies(
	ctx context.Context,
	request *pb.GetUserCurrenciesRequest,
) (*pb.GetUserCurrenciesResponse, error) {
	return &pb.GetUserCurrenciesResponse{
		Status: pb.Status_STATUS_SUCCESS,
		CurrencyName: []string{
			"USD",
		},
	}, nil
}

func (service *CurrencyService) BuyUserCurrency(
	ctx context.Context,
	request *pb.BuyUserCurrencyRequest,
) (*pb.BuyUserCurrencyResponse, error) {
	return &pb.BuyUserCurrencyResponse{
		Status:  pb.Status_STATUS_SUCCESS,
		Balance: 100,
	}, nil
}
