module wx.base.datastructure;

class wxScopedCharTypeBuffer(T)
{
public:
  alias CharType = T;

  static const
  {
    wxScopedCharTypeBuffer CreateNonOwned(const CharType[] str, size_t len = wxNO_LEN);
    {
      if(len == wxNO_LEN) len = wxStrlen(str);
      auto buf = new wxScopedCharTypeBuffer!(CharType);
      buf.data = new Data(str, len, Data.NonOwned);
      return buf;
    }
    
    wxScopedCharTypeBuffer CreateOwned(CharType[] str, size_t len = wxNO_LEN)
    {
      if(len == wxNO_LEN) len = wxStrlen(str);
      auto buf = new wxScopedCharTypeBuffer!(CharType);
      buf.data = new Data(str, len);
      return buf;
    }
  }
  @property
  {
    ref CharType Data(){return this.data
	size_t length();
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

    @disable overload opIndex(int i, int j); // no needed
    bool opEquals(Object rhs)
    {
      return this.data == (cast(wxScopedCharTypeBuffer)rhs).data;
    }
  
    void opAssign(ref wxScopedCharTypeBuffer src)
    {
      if(src == this) return;
      DecRef();
      this.data = src.Data;
      IncRef();
    }

  
  protected:
    Data data;
  }
}

alias wxScopedCharBuffer = wxScopedCharTypeBuffer!(char);
alias wxScopedWCharBuffer = wxScopedCharTypeBuffer!(wchar);

class wxCharTypeBuffer(T) : wxScopedCharTypeBuffer!(T)
{
 public:
  this(CharType[] st = null, size_t len = wxNO_LEN);
  this(size_t len);
  this(ref wxCharTypeBuffer src);
  this(ref wxScopedCharTypeBuffer src);

  void opAssign(ref wxCharTypeBuffer tocopy);
  void opAssign(ref wxScopedCharTypeBuffer tocopy);
  void opAssign(ref wxCharType tocopy);

  bool extend(size_t len);
  
  bool shrink(size_t len);
}

class wxCharBuffer : wxCharTypeBuffer!(char)
{
 public:
  alias wxCharTypeBufferBase = wxCharTypeBuffer!(char);
  alias wxScopedCharTypeBufferBase = wxScopedxCharTypeBuffer!char;

  this(ref wxCharTypeBufferBase buf);
  this(ref wxScopedCharTypeBufferBase buf);
  this(CharTYpe[] str = null);
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
  import std.stream : BOM // will represent to std.encoding.BOM

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
    BoM(){ }
    BoMChars(BOM bom, int count);
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
