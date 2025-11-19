SRCS = $(wildcard src/*.cpp)
OBJS = $(SRCS:=.o)
EXE  = battleship

# Everything below that should not have to change ever.
CXXFLAGS += -g -std=c++17 -Wall -Wextra -Wshadow
LDFLAGS  += -g -lncursesw

.PHONY: all
all: $(EXE)

$(EXE): $(OBJS)
	$(LINK.cc) -o $(EXE) $^ $(LIBS)

src/%.cpp.o: src/%.cpp
	$(COMPILE.cc) $< -o $@

.PHONY: run
run: $(EXE)
	./$(EXE)

.PHONY: clean
clean:
	-rm -f $(OBJS) $(EXE) solutions.txt
