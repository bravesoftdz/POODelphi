unit IPersistencia;

interface

  uses Variants,System.Classes;

  type
    TFieldType = (ftString, ftMemo, ftFloat, ftInteger, ftDate);


    IField = interface

      function getName:string;
      procedure setName(Value:string);

      function getFieldType:TFieldType;
      procedure setFieldType(Value:TFieldType);

      function getIsPk:Boolean;
      procedure setIsPk(Value:Boolean);

      function getString:string;
      procedure setString(Value:String);

      function getFloat:Double;
      procedure setFloat(Value:Double);

      function getInteger:Integer;
      procedure setInteger(Value:Integer);

      function getDate:TDateTime;
      procedure setDate(Value:TDateTime);

      function getValue:Variant;
      procedure setValue(Value:Variant);


      property Name:String read getName write setName;
      property FieldType:TFieldType read getFieldType write setFieldType;
      property isPk:Boolean read getIsPk write setIsPk;
      property AsString:string read getString  write setString;
      property AsFloat:Double read getFloat write setFloat;
      property AsInteger:integer read getInteger write setInteger;
      property AsDate:TDateTime read getDate write setDate;
      property AsValue:Variant read getValue write setValue;
    end;



    ITable = interface

      function getTableName():string;
      procedure setTableName(Value:String);

      function getIFields(Index:Integer):IField;
      procedure setIFields(Index:Integer;Value:IField);

      property TableName:String read getTableName write setTableName;
      property Fields[Index:Integer]:IField read getIFields write setIFields;
    end;

    //******************CLASSES ******************//

    TConvert = class
      class function VarToDateTime(Value:Variant):TDateTime;
      class function VarToInteger(Value:Variant):Integer;
      class function VarToDouble(Value:Variant):Double;

    end;


    TField = class(TInterfacedObject,IField)
     private
      FName:String;
      FFieldType:TFieldType;
      FIsPk:Boolean;
      FValue:Variant;
     protected

      function getName:string;virtual;
      procedure setName(Value:string);virtual;

      function getFieldType:TFieldType;  virtual;
      procedure setFieldType(Value:TFieldType);virtual;

      function getIsPk:Boolean;virtual;
      procedure setIsPk(Value:Boolean);virtual;

      function getString:string;virtual;
      procedure setString(Value:String);virtual;

      function getFloat:Double;virtual;
      procedure setFloat(Value:Double);virtual;

      function getInteger:Integer;virtual;
      procedure setInteger(Value:Integer);virtual;

      function getDate:TDateTime;virtual;
      procedure setDate(Value:TDateTime);virtual;

      function getValue:Variant;virtual;
      procedure setValue(Value:Variant);virtual;


      property Name:String read getName write setName;
      property FieldType:TFieldType read getFieldType write setFieldType;
      property isPk:Boolean read getIsPk write setIsPk;
      property AsString:string read getString  write setString;
      property AsFloat:Double read getFloat write setFloat;
      property AsInteger:integer read getInteger write setInteger;
      property AsDate:TDateTime read getDate write setDate;
      property AsValue:Variant read getValue write setValue;
     public
      constructor Create(lcName:String;ltFieldType:TFieldType;llPk:Boolean);
    end;


    TTable = class(TInterfacedObject,ITable)

      private
        FTableName:String;
        FFields:TList;
      protected
        function getTableName():string;virtual;
        procedure setTableName(Value:String);virtual;

        function getIFields(Index:Integer):IField;virtual;
        procedure setIFields(Index:Integer;Value:IField);virtual;

        constructor Create(lcTableName:String;laPk:Array of string);
    end;

implementation

{ TField }

constructor TField.Create(lcName: String; ltFieldType: TFieldType;
  llPk: Boolean);
begin
  inherited Create;
  FName := lcName;
  FFieldType := ltFieldType;
  FIsPk := llPk;
  FValue := '';
end;

function TField.getDate: TDateTime;
begin
  Result := TConvert.VarToDateTime(FValue);
end;

function TField.getFieldType: TFieldType;
begin
  Result := FFieldType;
end;

function TField.getFloat: Double;
begin
  Result := TConvert.VarToDouble(FValue);
end;

function TField.getInteger: Integer;
begin
  Result := TConvert.VarToInteger(FValue);
end;

function TField.getIsPk: Boolean;
begin
  Result := FIsPk;
end;

function TField.getName: string;
begin
  Result := FName;
end;

function TField.getString: string;
begin
  Result := FValue;
end;

function TField.getValue: Variant;
begin
  Result := FValue;
end;

procedure TField.setDate(Value: TDateTime);
begin
  FValue := Value;
end;

procedure TField.setFieldType(Value: TFieldType);
begin
  FValue := Value;
end;

procedure TField.setFloat(Value: Double);
begin
  FValue := Value;
end;

procedure TField.setInteger(Value: Integer);
begin
  FValue := Value;
end;

procedure TField.setIsPk(Value: Boolean);
begin
  FIsPk := Value;
end;

procedure TField.setName(Value: string);
begin
  FName := Value;
end;

procedure TField.setString(Value: String);
begin
  FValue := Value;
end;

procedure TField.setValue(Value: Variant);
begin
  FValue := Value;
end;

{ TConvert }

class function TConvert.VarToDateTime(Value: Variant): TDateTime;
begin
  try
    Result := variants.VarToDateTime(Value);
  except
    Result := 0;
  end;
end;

class function TConvert.VarToDouble(Value: Variant): Double;
begin
  try
    Result := Value;
  except
    Result := 0;
  end;
end;

class function TConvert.VarToInteger(Value: Variant): Integer;
begin
  try
    Result := Value;
  except
    Result := 0;
  end;  
end;

{ TTable }

constructor TTable.Create(lcTableName: String; laPk: array of string);
begin
  inherited Create;
  FTableName := lcTableName;
  FFields := TList.Create;
end;



function TTable.getIFields(Index: Integer): IField;
begin
  Result := IField(FFields[index]);    
end;

function TTable.getTableName: string;
begin
  Result := FTableName;
end;

procedure TTable.setIFields(Index: Integer; Value: IField);
begin
  FFields[INDEX] := @Value;  
end;

procedure TTable.setTableName(Value: String);
begin
  FTableName := Value;
end;

end.
