param(
  [Parameter(Mandatory=$True, Position=0, ValueFromPipeline=$false)]
  [System.String]
  $DiretorioInstalador,

  [Parameter(Mandatory=$True, Position=1, ValueFromPipeline=$false)]
  [System.String]
  $LocalInstalacao
)

if ([System.Environment]::Is64BitOperatingSystem)
{
  $Arquivo = "UltraVNC_X64_Setup.exe"
  ValidarArquivosInstalacao $Arquivo
  InstalarUltraVnc $LocalInstalacao $DiretorioInstalador $Arquivo
} else
{
  $Arquivo = "UltraVNC_X86_Setup.exe";
  ValidarArquivosInstalacao $Arquivo
  InstalarUltraVnc $LocalInstalacao $DiretorioInstalador $Arquivo
}


function ValidarArquivosInstalacao
{
  param (
    $NomeInstalador
  )
  if (!(DiretorioExiste("$DiretorioInstalador\$NomeInstalador")))
  {
    exit
  }
}
function InstalarUltraVnc
{
  param (
    $DiretorioInstalacao,
    $DiretorioInstalador,
    $Arquivo
  )
  Copy-Item "$DiretorioInstalador\$Arquivo" "$env:TEMP"
  cmd.exe /c "`"$env:TEMP\$Arquivo`" /dir=`"$DiretorioInstalacao`" /silent"
  
}

function DiretorioExiste
{
  param (
    $Diretorio
  )
  return [System.IO.File]::Exists($Diretorio)
}
