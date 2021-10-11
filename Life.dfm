object Form1: TForm1
  Left = 221
  Top = 121
  Width = 674
  Height = 573
  Caption = 'Life'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 497
    Height = 497
    OnClick = Image1Click
  end
  object Hor: TScrollBar
    Left = 8
    Top = 512
    Width = 497
    Height = 25
    PageSize = 0
    TabOrder = 0
    OnScroll = HorScroll
  end
  object Vert: TScrollBar
    Left = 512
    Top = 8
    Width = 25
    Height = 497
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnScroll = VertScroll
  end
  object GroupBox1: TGroupBox
    Left = 550
    Top = 0
    Width = 109
    Height = 369
    Caption = ' Actions '
    TabOrder = 2
    object LT: TLabel
      Left = 11
      Top = 138
      Width = 59
      Height = 16
      Caption = 'Lifetime: 0'
    end
    object Button1: TButton
      Left = 7
      Top = 98
      Width = 93
      Height = 31
      Caption = 'Load...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 7
      Top = 187
      Width = 93
      Height = 31
      Caption = 'Random'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 10
      Top = 226
      Width = 40
      Height = 31
      Caption = 'Z+'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 59
      Top = 226
      Width = 41
      Height = 31
      Caption = 'Z-'
      TabOrder = 3
      OnClick = Button4Click
    end
    object NN: TEdit
      Left = 10
      Top = 158
      Width = 90
      Height = 21
      TabOrder = 4
      Text = '200'
    end
    object Res: TButton
      Left = 7
      Top = 59
      Width = 93
      Height = 31
      Caption = 'Reset'
      TabOrder = 5
      OnClick = ResClick
    end
    object SW: TButton
      Left = 7
      Top = 20
      Width = 93
      Height = 30
      Caption = 'Start / Pause'
      TabOrder = 6
      OnClick = SWClick
    end
    object SPD: TEdit
      Left = 10
      Top = 266
      Width = 90
      Height = 21
      TabOrder = 7
      Text = '50'
    end
    object Button5: TButton
      Left = 10
      Top = 295
      Width = 92
      Height = 31
      Caption = 'Set speed'
      TabOrder = 8
      OnClick = Button5Click
    end
    object CheckBox1: TCheckBox
      Left = 10
      Top = 335
      Width = 90
      Height = 21
      Caption = 'Infinity field'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Button1Click2
    Left = 48
    Top = 16
  end
  object OD: TOpenDialog
    Filter = 'Life configurations (*.life)|*.life'
    Left = 16
    Top = 16
  end
end
