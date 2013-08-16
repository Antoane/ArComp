unit ARC_DbGrid;

interface

uses
  Vcl.DBGrids,
  System.Classes;

type
  TDbGrid = class(Vcl.DBGrids.TDbGrid)
  private

  public
    constructor create(aOwner: TComponent); override;
    destructor destroy; override;

  published
    procedure TitleClick(Column: TColumn);

  end;

implementation

{TDbGrid}

constructor TDbGrid.create(aOwner: TComponent);
begin
  inherited create(aOwner);

end;

destructor TDbGrid.destroy;
begin
  inherited destroy;
end;

procedure TDbGrid.TitleClick(Column: TColumn);
begin
  inherited Visible := false;
end;

end.
