import setuptools

with open("README.md") as fh:
  longdesc = fh.read()

setuptools.setup(
  name="fos-uom-apt",
  version="0.0.1",
  description="FOS Runtime FPGA OS Python libraries",
  long_description=longdesc,
  long_description_content_type="text/markdown",
  url="https://github.com/khoapham/fos",
  packages=setuptools.find_packages(),
  python_requires=">=3.6"
)
