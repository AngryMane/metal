#ifndef PARSER_DEF_H
#define PARSER_DEF_H

#include <string>
#include <vector>
#include <string>
#include <iostream>
#include <fstream>


struct PropertyBase;

enum DATA_TYPE{
  DATA_TYPE_TEXT,
  DATA_TYPE_PROPERTY,
  DATA_TYPE_INSTANCE,
  DATA_TYPE_NUM,
};

struct Data{

  Data(DATA_TYPE data_type)
  : data_type_(data_type){}

  DATA_TYPE data_type_;
};

struct Text : public Data{

  Text()
  : Data(DATA_TYPE_TEXT)
  , value_(){}

  Text(std::string value)
  : Data(DATA_TYPE_TEXT)
  , value_(){}

  Text operator+(const Text& rhs){
    return Text(value_ + rhs.value_);
  }

  Text& operator=(const Text& rhs){
    if (rhs.value_.empty()){
      value_.clear();
      return *this;
    }
    value_ = rhs.value_;
    return *this;
  }

  std::string value_;
};

struct Instance : public Data{

  Instance(DATA_TYPE data, std::string value)
  : Data(DATA_TYPE_INSTANCE){}

  std::vector<PropertyBase*> properties_;
};

struct PropertyBase : public Data{

  PropertyBase(
    std::string id,
    std::string name,
    std::string prop_type)
  : Data(DATA_TYPE_PROPERTY)
  , id_(id)
  , name_(name)
  , prop_type_(prop_type){}

  std::string id_;
  std::string name_;
  std::string prop_type_;
};

struct SimpleProperty : public PropertyBase{

  SimpleProperty (
    std::string id,
    std::string name,
    std::string prop_type,
    std::string value)
  : PropertyBase(id, name, prop_type)
  , value_(value){}

  std::string value_;
};

struct ComplexProperty : public PropertyBase{

  ComplexProperty(
    std::string id,
    std::string name,
    std::string prop_type,
    std::string value)
  : PropertyBase(id, name, prop_type){}

  std::vector<Instance*> instance_;
};

#endif // PARSER_DEF_H
