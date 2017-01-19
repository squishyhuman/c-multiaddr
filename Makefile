CC = gcc
CFLAGS = -O0 -I include 

ifdef DEBUG
CFLAGS += -g3
endif

LFLAGS = -lm
DEPS = include/multiaddr/base58.h include/multiaddr/endian.h include/multiaddr/multiaddr.h \
	include/multiaddr/protocols.h include/multiaddr/protoutils.h include/multiaddr/varhexutils.h \
	include/multiaddr/varint.h
OBJS = base58.o varint.o

all: libmultiaddr.a

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

libmultiaddr.a: $(OBJS)
	ar rcs $@ $^

test_multiaddr: testing.o libmultiaddr.a
	$(CC) -o $@ $^ $(LFLAGS)

clean:
	rm -f *.o
	rm -f libmultiaddr.a
	rm -f test_multiaddr

test: test_multiaddr
	./test_multiaddr
