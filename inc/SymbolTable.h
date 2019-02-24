#ifndef SYMBO_TABLE_H
#define SYMBO_TABLE_H

#include "external.h"

class SymbolTable{

public: // initialize/filnalize

  // constructor
  SymbolTable(
      std::string name = "",
      SymbolTable* parent = NULL)
      : m_Name(name)
      , m_Parent(parent){
    if (m_Parent == NULL){
      return;
    }
    m_Parent->m_Children.push_back(this);
  }

  // destructor
  virtual
  ~SymbolTable(){
  }

public: // operation

  llvm::Value*
  Search(
      std::string name){
    auto itr = m_SymbolData.find(name);
    return \
      (itr != m_SymbolData.end())? (itr->second) : \
      (m_Parent == NULL)?          (NULL) : \
                                   (m_Parent->Search(name));
  }

  void
  AddSymbol(
      std::string name,
        llvm::Value* value){
    auto itr = m_SymbolData.find(name);
    if (itr != m_SymbolData.end()){
      std::cout << name << "is already defined." << std::endl;
      return;
    }

    m_SymbolData[name] = value;
  }

  SymbolTable*
  GetParent(){
    return m_Parent;
  }

public: // query

private: // private methods

private: // private member vars

  std::string m_Name;

  SymbolTable* m_Parent;

  std::vector<SymbolTable*> m_Children;

  std::map<std::string, llvm::Value*> m_SymbolData;

};

#endif
