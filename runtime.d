
class wxObject
{
public:
  this();
  ~this();
  void Ref(wxObject clone);
  void UnRef(wxObject object);
  @property
  {
    @override auto dup(wxObject[] a);
    wxClassInfo ClassInfo();
    wxObjectRefData RefData();
    bool IsKindOf(wxClassInfo info);
    bool IsSameAs(wxClassInfo info);
    
  }
  
}

class wxObjectRefData
{
}

class wxObjectRefData(T)
{
}

class wxRefCounter
{
}

class wxClassInfo
{
}
