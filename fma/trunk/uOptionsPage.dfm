object frmOptionsPage: TfrmOptionsPage
  Left = 516
  Top = 215
  ActiveControl = btnPageOK
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 65
  ClientWidth = 221
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    221
    65)
  PixelsPerInch = 96
  TextHeight = 13
  object btnPageOK: TTntButton
    Left = 64
    Top = 32
    Width = 69
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnPageOKClick
  end
  object btnPageCancel: TTntButton
    Left = 144
    Top = 32
    Width = 69
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
end
