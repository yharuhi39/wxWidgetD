module wxwidgetd.base.rtti;

class wxObject
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
    @disabled auto dup(wxObject[] a)
    {
      throw new UnImplementedOperationException();
    }

    wxObject Ref(wxObject clone)
    {
      if(this.RefData == clone.RefData) return;

      UnRef();

      if(clone.RefData)
	{
	  this.RefData = clone.RefData;
	  this.RefData.IncRef();
	}
    }
    
    wxClassInfo ClassInfo(){ return this.classinfo; }
    wxObjectRefData RefData(){ return this.refData; }
    void RefData(wxObjectRefData data){ this.refData = data; }
  }

  bool IsKindOf(wxClassInfo info){ return (this.ClassInfo) ? this.ClassInfo.IsKindOf(info) : false; }

  bool IsSameAs(wxClassInfo info){ return this.RefData == o.RefData; }

  override bool opEquals(Object info){ return this.ClassInfo == cast(wxClassInfo)info; }

  void destroy(wxObject buf) { this.RefData = null; super.destroy(); }
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

alias wxObjectRefData = wxRefCounter; //considered to be deleted

class wxObjectRefData(T)
{
public:
  alias elementType = T;
  
  this(ref T ptr = null)
  {
    this.pointer = ptr;
  }

  // It it not sure that it would work.
  @disable this(wxObjectData copy)
  {
    this.Pointer = copy.Pointer;
  }

  @property
  {
    T Pointer(){ return this.pointer; }
    void Pointer(T val){this.pointer = val; }
  }
  ~this()
  {
    if(this.pointer) this.pointer.DecRef();
  }

  void reset(ref T ptr)
  {
    if(pointer) pointer.DecRef();
    pointer = ptr;
  }
  
  void opAssign(wxObjectData tocopy)
  {
    if(pointer) pointer.DecRef();
    pointer = tocopy.Pointer;
    if(pointer) pointer.IncRef();
  }

  void opAssign(ref T ptr)
  {
    if(pointer) pointer.DecRef();
    pointer = ptr;
  }
  @diabled T unspecified_bool_type() { return this.pointer? this.Pointer : null; }

private:
  T pointer;
}

class wxRefCounter
{
public:
  this(){ this.count = 1;}
  void DecRef();
  void IncRef(){this.count++;}
  @property
  {
    int RefCount();
    //    void RefCount(int value){ this.count = value; }
  }
protected:
  ~this();

private:
  int count;
}

class wxClassInfo
{
public:
  
  this(const wxString className, wxClassInfo baseClass1, wxClassInfo baseClass2, int size, wxObjectConstructorFn fn)
  {
  }
  
  ~this()
  {
    if(this == classInfo[0])
      classInfo.remove(classInfo[0]);
  }
  const wxObject createObject()
  {
  }

  void Register()
  {
    version(DEBUG)
      {
	static int entry = 0;
      }

    wxHashTable classTable;
    if(this.classTable)
      {
	classTable = new wxHashTable(wxKeyString);
      }
    else
      {
	wxAsser_Message(++entry == 1, wxT("wxClassInfo::Register() reentrance"));
	classTable = this.classTable;
      }
  }

  void Unregister()
  {
    if(this.classInfo)
      {
	this.classInfo.remove(this.className);
	if(this.classInfo.Count == 0) wxDELETE(this.classTable);
      }
  }

  wxObject CreateObject();
  
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
    if(this.classTable)
      return cast(wxClassInfo)(wxClassInfo.classTable.get(className));
    else
      {
	foreach(wxClassInfo info; wxClassInfo.classInfo)
	  {
	    if(className == info.ClassName) return info;
	  }
	return null;
      }
  }

private:
  static wxClassInfo[] classInfo;
  
}
