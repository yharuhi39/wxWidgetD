module wxwidgetd.base.datastructure;

class wxScopedCharTypeBuffer(T)
{
public:
  alias CharType = T;
  
  static const
  {
    wxScopedCharTypeBuffer CreateNonOwned(const CharType[] str)
    {
      auto buf = new wxScopedCharTypeBuffer!(CharType);
      buf.data = new DataType(str, DataType.Kind.NonOwned);
      return buf;
    }
    
    wxScopedCharTypeBuffer CreateOwned(CharType[] str)
    {
      auto buf = new wxScopedCharTypeBuffer!(CharType);
      buf.data = new DataType(str);
      return buf;
    }
  }
  @property
  {
    ref CharType Data(){ return this.data; }
  }
    
  this()
  {
    this.data = null;
  }
  
  ~this()
  {
    this.DecRef();
  }

  CharType[] release();

  void reset();

  @disable T[] opIndex(int i, int j); // no needed
  override bool opEquals(Object rhs)
  {
    return this.data == (cast(wxScopedCharTypeBuffer)rhs).data;
  }
  
  
protected:
  struct DataType
  {
    enum Kind
      {
	Owned,
	NonOwned
      }
    this(CharType[] str, Kind kind = Kind.Owned)
    {
      this.data = str;
    }

    @property
    {
      CharType[] Data(){ return this.data; }
      void Data(CharType[] str){ this.data = str; }
    }
    ushort reference;
    bool owned;
    CharType[] data;
  }
  DataType data;
}

alias wxScopedCharBuffer = wxScopedCharTypeBuffer!(char);
alias wxScopedWCharBuffer = wxScopedCharTypeBuffer!(wchar);

class wxCharTypeBuffer(T) : wxScopedCharTypeBuffer!(T)
{
 public:
  alias CharType = T;
  
  this(CharType[] st = null);
  this(size_t len);

  void opAssign(CharType[] tocopy);

  bool extend(size_t len);
  
  bool shrink(size_t len);
}

class wxCharBuffer : wxCharTypeBuffer!(char)
{
 public:
  alias wxCharTypeBufferBase = wxCtuharTypeBuffer!(char);
  alias wxScopedCharTypeBufferBase = wxScopedCharTypeBuffer!(char);

  this(ref wxCharTypeBufferBase buf);
  this(ref wxScopedCharTypeBufferBase buf);
  this(CharType[] str = null);
  this(size_t len);
  this(ref wxCStrData cstr);
}
  
class wxWCharBuffer
{
}

class wxNode(T)
{
  
public:
  @property
  {
    ref T Data(){ return this.data; }
    void Data(ref T data){this.data = data; }
    ref T Previous() { return this.previous; }
    ref T Next(){ return this.next; } 
  }

  int indexOf()
  {
    bool loop = true;
    T cur, prev = this;
    int cnt;
    while(loop)
      {
	this.cur = prev;
	prev= cur.prev;
	loop = prev != null;
	if(loop)cnt++;
      }
    return cnt;
  }
private:
  ref T previous, data, next;
}

class wxAboutDialogInfo
{
}

class wxAcceleratorEntry
{
}

class wxAcceleratorTable
{
}

class wxAny
{
}

class wxAnyValueType
{
}

class wxMemoryBuffer
{
}

class wxCalenderDateAttr
{
}

class wxPageSetupData
{
}

class wxPrintDialogData
{
}


class wxConvAuto : wxConv
{
public:
  import std.stream : BOM; // will represent to std.encoding.BOM

  this(wxFontEncoding enc = wxFontEncodingDefault)
  {
    init();
    encodingDefault = enc;
  }

  this(ref wxConvAuto other)
  {
    super();
    init();
    this.encodingDefault = other.encodingDefault;
  }

  ~this() { if(this.ownsConv)conv.destroy(); }
  @property
  {
    BOM BoM(){ }
    wxString BOMBoMChars(BOM bom, int count); // ?o
    static wxFontEncoding FallbackEncoding();
    static void FallbackEncoding(wxFontEncoding enc);
  }

  static void DisableFallbackEncoding();
  static BOM DetectBOM(string src);

private:
  void init()
  {
    this.conv = null;
    this.bomType = null; // this can be deferent
    this.ownConversion = false;
    this.consumeBOM = false;
  }

  void initWithUTF8()
  {
    this.conv = wxConvUTF8;
    this.ownConversion = false;
  }

  static wxFontEncoding defaultEncoding;
  wxConv conv;
  wxFontEncoding encoding; // this will be deleted because all input is defined in defaultEncoding...
  BOM bomType;
  bool ownConversion;
  bool consumeBOM;
}

class wxDateTime
{
public:
  alias wxDateTime_t = ushort;

  enum TimeZone : byte
    {
      Local,
	GMT_12 = -12,
	GMT_11 = -11,
	GMT_10 = -10,
	GMT_9  = -9,
	GMT_8  = -8,
	GMT_7  = -7,
	GMT_6  = -6,
	GMT_5  = -5,
	GMT_4  = -4,
	GMT_3  = -3,
	GMT_2  = -2,
	GMT_1  = -1,
	GMT0   =  0,
	GMT13 = 13,
	GMT12  = 12,
	GMT11  = 11,
	GMT10  = 10,
	GMT9   = 9,
	GMT8   = 8,
	GMT7   = 7,
	GMT6   = 6,
	GMT5   = 5,
	GMT4   = 4,
	GMT3   = 3,
	GMT2   = 2,
	GMT1   = 1,

	WST = GMT0,
	WEST = GMT1,
	CET = GMT1,
	AST = GMT_4,
	ADT = GMT_3,
	EST = GMT_5,
	EDT = GMT_4,
	CST = GMT_6,
	CDT = GMT_5,
	MST = GMT_7,
	MDT = GMT_6,
	PST = GMT_8,
	PDT = GMT_7,
	HST = GMT_10,
	AKST = GMT_9,
	AKDT = GMT_8,
	
	A_WST = GMT8,
	A_CST = GMT13 + 1,
	A_EST = GMT10,
	A_ESST = GMT11,

	NZST = GMT12,
	NZDT = GMT13,

	UTC = GMT0
	}

  
  enum Month
    {
      Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
    }

  
  
private:
}

class wxDateTimeWorkDays
{
}

class wxDateSpan
{
}

class wxTimeSpan
{
}

class wxDateTimeHolidayAuthority
{
}
