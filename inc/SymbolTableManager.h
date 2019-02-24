#ifndef SYMBO_TABLE_MANAGER_H
#define SYMBO_TABLE_MANAGER_H

#include "external.h"
#include "SymbolTable.h"

class SymbolTableManager{

public: // initialize/filnalize

  // constructor
  SymbolTableManager(){
  }

  // destructor
  virtual
  ~SymbolTableManager(){
  }

public: // operation

  llvm::Value*
  Search(
      std::string name){
    auto ret = m_CurrentScope->Search(name);
    return (ret != NULL)? (ret) : (NULL);
  }

  void
  AddSymbol(
      std::string name,
        llvm::Value* value){
    m_CurrentScope->AddSymbol(name, value);
  }

  void
  PlusScopeIndent(
      std::string name){
    SymbolTable* cur = new SymbolTable(name, m_CurrentScope);
    m_CurrentScope = cur;
  }

  void
  MinusScopeIndent(){
    m_CurrentScope = m_CurrentScope->GetParent();
  }

public: // query

private: // private methods

private: // private member vars

  SymbolTable* m_CurrentScope;

};

#endif

