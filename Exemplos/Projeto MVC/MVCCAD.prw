#Include "Protheus.ch"
#Include "FwMvcDef.ch"

/*
@author Bruno Domingos
@since 25/06/2024
@version version
*/

/*Programa Inicial*/
User Function MVCCAD()
Local oBrowse := FwLoadBrw("MVCCAD")

oBrowse:Activate()

Return

/*Responsável por criar o Browse*/
Static Function BrowseDef()
Local oBrowse   := FwmBrowse():New()

oBrowse:SetAlias("SZ9")
oBrowse:SetDescription("Tela MVC CADASTRO DE ALUNOS")

oBrowse:AddLegend("SZ9->Z9_STATUS == '1'","GREEN","Cadastro Ativo")
oBrowse:AddLegend("SZ9->Z9_STATUS == '2'","RED","Cadastro Inativo")

oBrowse:SetOnlyField({"Z9_CODIGO","Z9_NOME","Z9_ESTCIV","Z9_STATUS"})

oBrowse:DisableDetails()

oBrowse:Activate()

Return oBrowse

/*Camada de controle (Menu)*/
Static Function MenuDef()
Local aMenu /*aRotina*/ := {}

ADD OPTION aMenu TITLE 'Pesquisar'       ACTION 'PesqBrw'                OPERATION 1 ACCESS 0
ADD OPTION aMenu TITLE 'Visualizar'      ACTION 'VIEWDEF.MVCCAD'         OPERATION 2 ACCESS 0
ADD OPTION aMenu TITLE 'Incluir'         ACTION 'VIEWDEF.MVCCAD'         OPERATION 3 ACCESS 0
ADD OPTION aMenu TITLE 'Alterar'         ACTION 'VIEWDEF.MVCCAD'         OPERATION 4 ACCESS 0
ADD OPTION aMenu TITLE 'Excluir'         ACTION 'VIEWDEF.MVCCAD'         OPERATION 5 ACCESS 0
ADD OPTION aMenu TITLE 'Imprimir'        ACTION 'VIEWDEF.MVCCAD'         OPERATION 8 ACCESS 0
ADD OPTION aMenu TITLE 'Copiar'          ACTION 'VIEWDEF.MVCCAD'         OPERATION 9 ACCESS 0

Return aMenu

/*Camada do modelo de Dados*/
Static Function ModelDef()
Local oModel := Nil

Local oStructSZ9   := FwFormStruct(1,"SZ9")

oModel := MPFormModel():New("MVCCADM",,,,)

oModel:AddFields("FORMSZ9",,oStructSZ9)

oModel:SetPrimaryKey({"Z9_FILIAL","Z9_CODIGO"})

oModel:SetDescription("Modelo de dados MVCCAD")

oModel:GetModel("FORMSZ9"):SetDescription("Formulário de Cadastro SZ9")

Return oModel

/*Camada de visao, controla o que é exibido na tela*/
Static Function ViewDef()
Local oView := Nil

Local oModel    := FwLoadModel("MVCCAD")

Local oStructSZ9    := FwFormStruct(2,"SZ9")

oView   := FwFormView():New()

oView:SetModel(oModel)

oView:AddField("VIEWSZ9",oStructSZ9,"FORMSZ9")

oView:CreateHorizontalBox("TELASZ9",100)

oView:EnableTitleView("VIEWSZ9","VISUALIZAÇÃO DOS PROTHEUZEIROS")

oView:SetCloseOnOk({|| .T.})

oView:SetOwnerView("VIEWSZ9","TELASZ9")

Return oView

