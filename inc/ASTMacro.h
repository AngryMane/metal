#ifndef AST_MACRO_H
#define AST_MACRO_H

/*
 * NOTE: This macro changes access control to 'private'
 */
#define MEMBER_WITH_GET(TYPE,NAME) \
public: \
TYPE \
Get##NAME() const{ \
  return m_##NAME;\
} \
\
private: \
TYPE m_##NAME;

/*
 * NOTE: This macro changes access control to 'private'
 */
#define MEMBER_WITH_GET_SET(TYPE,NAME) \
public: \
TYPE \
Get##NAME() const{ \
  return m_##NAME;\
} \
void \
Set##NAME(\
    TYPE& NAME){ \
  m_##NAME = NAME;\
}\
\
private: \
TYPE m_##NAME;

#endif
