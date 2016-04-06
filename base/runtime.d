
class wxObject : Object
{
public:
  const wxClassInfo[] classParents = { null };

  this(){ this.RefData = null; }

  ~this(){ this.UnRef(); }

  void Ref(wxObject clone)
  {
    if(this.RefData == clone.RefData) return;
    this.Unref();
    if(clone.RefData)
      {
	this.RefData = clone.RefData;
	this.RefData.IncRef();
      }
  }
  
  void UnRef()
  {
    if(this.RefData)
      {
	this.RefData.DecRef();
	this.RefData = null;
      }
  }

  void UnShare(){ this.AllocExclusive(); }

  @property
  {
    override auto dup(wxObject[] a)
    {
      wxObject[] ret;
      ret.length = a.length;
      foreach(wxObject obj; a)
	{
	  if(this.RefData == )
	    {
	    }
	}
    }
    wxClassInfo ClassInfo(){ return this.classinfo; }
    wxObjectRefData RefData(){ return this.refData; }
    void RefData(wxObjectRefData data){ this.refData = data; }
  }

  bool IsKindOf(wxClassInfo info){ return (this.ClassInfo) ? this.ClassInfo.IsKindOf(info) : false; }

  bool IsSameAs(wxClassInfo info){ return this.RefData == o.RefData}

  override bool opEquals(Object info){ return this.ClassInfo == cast(wxClassInfo)info; }

  override void destroy(wxObject buf) throws Exception { throw new Exception("Error"); }
protected:

  wxObjectRefData refData;
  
  void AllocExclusive()
  {
    if(!this.RefData)
      {
	this.RefData = this.CreateRefData();
      }
  }
  const wxObjectRefData CreateRefData()
  {
    return null;
  }
  const wxObjectRefData CloneRefData(wxObjectRefData data);
  
}

class wxObjectRefData
{
}

class wxObjectRefData(T)
{
}

class wxRefCounter
{w
}

class wxClassInfo
{
public:
  this(const wxString className, wxClassInfo baseClass1, wxClassInfo baseClass2, int size, wxObjectConstructorFn fn);
  const wxObject createObject();
  @property
  {
    wxString BaseClassName1();
    wxString BaseClassName1();
    wxString ClassName();
    int Size();
    bool IsDynamic();
    bool IsKindOf(wxClassInfo info);
  }

  static wxClassInfo FindClass(wxString className)
  {
    if(
  }
  
}
