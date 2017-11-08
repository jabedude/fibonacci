.PHONY: clean

BINS=fibonacci

DEPS1=fibonacci.s

all: $(BINS)
fibonacci: $(DEPS1)

clean:
	$(RM) $(DEPS1) $(BINS)

