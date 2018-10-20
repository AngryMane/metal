#ifndef ROOTAST_H
#define ROOTAST_H

#include "external.h"
#include "ASTCommon.h"
#include "BaseAST.h"

class RootAST : public BaseAST {

public: // initialize/filnalize

  // constructor
  RootAST()
    : BaseAST(AST_TYPE_ROOT)
    , m_Decls(){
  }

  // destructor
  virtual
  ~RootAST(){
    for (auto cur : m_Decls) delete cur;
  }

public: // operation

  void AddDecl(
    BaseAST* decl){
    m_Decls.push_back(decl);
  }

public: // query

private: // private methods

private: // private member vars

  MEMBER_WITH_GET_SET(std::vector<BaseAST*>, Decls)

};

#endif
