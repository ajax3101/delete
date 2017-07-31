program del;

uses
  windows,sysutils;

{$R *.res}

procedure del_dir(curdir:string;del_cur:boolean);
var
sr: TSearchRec;
begin
     if findfirst(curdir+'*.*',$3f,sr)=0 then
     begin
         if (sr.Name<>'.') and (sr.Name<>'..') then
         if sr.attr and $10 = 0  then
         try
             SetFileAttributes(pchar(curdir+sr.name),FILE_ATTRIBUTE_NORMAL);
             DeleteFile(curdir+sr.name);
         except
         end
         else
            del_dir(curdir+sr.name+'\',true);
         while FindNext(sr) = 0 do
             if (sr.Name<>'.') and (sr.Name<>'..') then
             if sr.attr and $10 = 0 then
             try
                SetFileAttributes(pchar(curdir+sr.name),FILE_ATTRIBUTE_NORMAL);
                DeleteFile(curdir+sr.name);
             except
             end
             else
                del_dir(curdir+sr.name+'\',true);
     end;
     findclose(sr);
     if del_cur then
     try
     SetFileAttributes(pchar(copy(curdir,1,length(curdir)-1)),FILE_ATTRIBUTE_NORMAL);
     rmdir(copy(curdir,1,length(curdir)-1));
     except
     end
end;

begin
//  Application.Initialize;
//  Application.Run;
  if ParamStr(1)='' then
  begin
  messagebox(0,
  'Use program: del.exe [path].','warning',MB_ICONWARNING or MB_OK);
  exit;
  end;
  if ParamStr(1)[length(ParamStr(1))]<>'\' then
  del_dir(ParamStr(1)+'\',false)
  else
  del_dir(ParamStr(1),false)
end.
