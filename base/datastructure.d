package base.datastructure;

class wxScopedCharTypeBuffer(T)
{
public:
  alias CharType = T;

  static const
  {
    wxScopedCharTypeBuffer CreateNonOwned(const CharType[] str, size_t len = wxNO_LEN);

    wxScopedCharTypeBuffer CreateOwned(CharType[] str, size_t len = wxNO_LEN);
  }
  @property
  {
    ref CharType Data();
    size_t length();
  }
  this();
  ~this();

  CharType[] release();

  void reset();

  @disable overload opIndex(int i, int j); // no needed
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
  this(ref wxCStrData cstr)
}

class wxWCharBuffer
{
}

class wxMode(T)
{
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

class wxColourData
{
}

class wxConvAuto
{
}

class wxDateTime
{
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
