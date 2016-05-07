module wxd.core.datastructure;

import wxd.base.datastructure;

class wxColorData
{
public:
  enum
    {
      NumberOfCustomColors = 16;
      ColumnDataSeparator = ',';
    }

  this()
  {
    this.chooseFull = false;
    this.chooseAlpha = false;
    this.dataColor.set(0,0,0);

  }
  this(ref wxColorData data)
  {
    this.chooseFull = data.ChooseFull;
    this.chooseAlpha = data.ChooseAlpha;
    this.dataColor = data.Color;
    this.customColors = data.CustomColors;
  }
  ~this(){}

  @property
  {
    void ChooseAlpha(bool flag){ this.chooseAlpha = flag; }
    bool ChooseAlpha(){ return this.chooseAlpha; }
    void ChooseFull(bool flag){ this.chooseFull = flag; }
    bool ChooseFull(){ return this.chooseFull; }
    wxColor CustomColor(int i){ assert(i>0&&i<NumberOfCustomColors); return this.customColors[i]; }
    wxColor[] CustomColors(){ return this.customColors; }
    void CustomColor(int i, wxColor color){assert(i>0&&i<NumberOfCustomColors); this.customColors[i] = color; }
    wxColor Color(){ this.dataColor; }
    void Color(wxColor color){this.dataColor = color; }
  }

  wxString toString()
  {
    string str = this.chooseFull?'1':'0';
    foreach(wxColor c; this.customColors)
      {
	str ~= ColumnDataSeparator;
	if(c.OK) str ~= c.GetAsString(wxColor.Syntax.HTML);
      }
    str ~= ColumnDataSeparator;
    str ~= this.chooseAlpha?'1':'0';
    return new wxString(str);
  }

  bool fromString(wxString str);

  wxColorData opAssign(wxColorData data)
  {
    this.customColors = data.CustomColors;
    this.chooseFull = data.ChooseFull;
    this.chooseAlpha = data.ChooseAlpha;
    this.dataColor = data.Color;
    this.customColors = data.CustomColors;
  }

private:
  wxColor dataColor;
  wxColor[NumberOfCustomColors] customColors;
  bool chooseFull;
  bool chooseAlpha;  
}
