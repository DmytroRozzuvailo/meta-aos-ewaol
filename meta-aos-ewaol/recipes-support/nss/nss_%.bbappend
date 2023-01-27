PR = "l1"
# cc1: error: switch '-mcpu=neoverse-n1+crc+crypto' conflicts with '-march=armv8-a+crypto' switch [-Werror]
TUNE_CCARGS:remove = "-mcpu=neoverse-n1+crc+crypto"

TARGET_CC_ARCH += "${LDFLAGS}"
