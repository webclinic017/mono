"""
A setuptools based setup module.
See:
https://packaging.python.org/guides/distributing-packages-using-setuptools/
https://github.com/pypa/sampleproject
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
import pathlib

here = pathlib.Path(__file__).parent.resolve()

# Get the long description from the README file
long_description = (here / "README.md").read_text(encoding="utf-8")

# Arguments marked as "Required" below must be included for upload to PyPI.
# Fields marked as "Optional" may be commented out.

setup(
    name="mono",
    version="1.0.0",
    description = "Python project to research trading signals",
    long_description = long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/veganafro/mono/python",
    author = "Jeremy Muhia",
    classifiers = [
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "Topic :: Software Development",
        "License :: MIT License",
        "Programming Language :: Python :: 3.9",
    ],
    package_dir={"": "src"},
    packages = find_packages(where="src", exclude=["venv", "notebooks"]),
    python_requires=">=3.9, <4",
    install_requires=[
        "vectorbt[full]==0.22.0",
    ],
    project_urls={
        "Source": "https://github.com/veganafro/mono/python",
    },
)
