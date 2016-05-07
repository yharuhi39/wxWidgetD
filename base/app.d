module wxwidgetd.base.app;

class wxApp : wxAppConsole
{
public:
  /**
     Constructor.
   */
  this();
  /**
     Destructor.
   */
  ~this();
  @property
  {
    /**
       Returns:
       Display mode that is used use.
     */
    wxVideoMode DisplayMode();
    /**
       RETURN:
       Display mode that is used use.
     */
    bool ExitOnFrameDelete();
    wxLayoutDirection LayotDirection();
    bool UseBestVisual();
    wxWindow TopWindow();
    bool Active();
    void DisplayMode(wxVideoMode info); // throws Exception;
    void ExitOnFrameDelete(bool flag);
    void NativeTheme(wxString theme);// throws Exception;
    void TopWindow(wxWindow window); // throws Exception;
    void UseBestVisual(bool flag, bool forceTrueColor=false);
  }

  version(OSX)
  {
    void MacNewFile();
    void MacOpenFiles(wxArrayString fileNames);
    void MacOpenFile(wxString fileName);
    void MacOpenURL(wxString url);
    void MacPrintFile(wxString fileName);
    void MacReopenApp();
    @property void OSXGUIApplication();
  }
}

class wxAppConsole
{
}

class wxCmdLineParser
{
}

class wxDynamicLibrary
{
}

class wxEventLoopBase
{
}

class wxGUIEventLoop
{
}

class wxInitializer
{
}

class wxModule
{
}

class wxProcess
{
}

class wxSingleInstanceChecker
{
}
