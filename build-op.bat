@echo off
SET zip="C:\Program Files\7-Zip\7z.exe"
for %%I in (.) do SET CurrDirName=%%~nxI

IF EXIST %CurrDirName%.op (
  del %CurrDirName%.op
)
%zip% a -mx1 -tzip %CurrDirName%.op info.toml src
