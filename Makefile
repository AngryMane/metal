CC := g++
CFLANGS := -g -std=c++11 -oresult/lexer.a -Irules/
FLEX := flex++
BISON := bison

RULE_DIR = rules
SRC_DIR := src

FLEX_TARGET += token.l
FLEX_INPUTS = $(addprefix $(RULE_DIR)/, $(FLEX_TARGET))
FLEX_OUTPUT = $(SRC_DIR)/token.cpp
FLEX_FLAGS = --header-file=$(SRC_DIR)/token.hpp -o$(FLEX_OUTPUT)

BISON_TARGET += syntax.y
BISON_INPUTS = $(addprefix $(RULE_DIR)/, $(BISON_TARGET))
BISON_FLAGS = -d -o$(SRC_DIR)/syntax.cpp

all: generate compile

generate: flex bison move

flex:	
	$(FLEX) $(FLEX_FLAGS) $(FLEX_INPUTS) 

bison:
	$(BISON) $(BISON_FLAGS) $(BISON_INPUTS) 

move:
	cp $(RULE_DIR)/*.h $(SRC_DIR)

compile:
	$(CC) $(CFLANGS) $(SRC_DIR)/token.cpp $(SRC_DIR)/syntax.cpp 

clean:
	rm -rf $(SRC_DIR)/*

debug:
	echo $(FLEX_TARGET)
