@echo off
@setlocal enabledelayedexpansion

set base_path=content/reference/

echo [1] �L�������
echo [2] �J�e�S���[�����
echo [0] �I��

:SelectMenu
set /p make_cat="���j���[��I��ł��������B"

echo %make_cat%

IF 1 EQU %make_cat% (
    echo �L�������܂�
    goto MakePost
) ELSE IF 2 EQU %make_cat% (
    echo �J�e�S���[�����܂�
    goto MakeCategory
) ELSE IF 0 EQU %make_cat% (
    echo �I�����܂�
    goto End
) ELSE (
    goto SelectMenu
)

:MakePost
set counter=0

rem �f�B���N�g�����擾���ċ^���z��Ɋi�[
for /d %%f in (%base_path%*) do (
    set cats[!counter!]=%%f
rem    echo cats[!counter!]��%%f�������܂����B
    set /a counter+=1
)
echo %counter%�̃J�e�S���[��������܂����B
echo;

set /a max_count=%counter%-1

set counter=0
for /l %%n in (0,1, %max_count%) do (
    echo !counter!: !cats[%%n]!
    set /a counter+=1
)

:SelectCategory
echo;
set /p category="��L�̃J�e�S���[�̔ԍ���I�����Ă��������B"

if %category% GTR %max_count% (
    echo ���l���傫�����܂��B�ēx���͂��Ă��������B
    echo;
    goto SelectCategory
) else (
    if %category% lss 0 (
    echo ���l�����������܂��B�ēx���͂��Ă��������B
    echo;
    goto SelectCategory
    )
)

set create_path=%base_path%!cats[%category%]!/

echo �I�񂾃J�e�S���[��!cats[%category%]!�ł��B
echo �p�X�� %create_path% �ł�
echo;

set /p title="�L���̃^�C�g������͂��Ă��������B�����͕����񂪃t�@�C�����ɂȂ�܂��B"

hugo new %create_path%%title%/index.md
goto End

:MakeCategory
set /p ctitle="�J�e�S���[�̃^�C�g������͂��Ă��������B�����͕����񂪃J�e�S���[���ɂȂ�܂��B"

hugo new %base_path%%ctitle%/_index.md
goto End

:End

timeout 2
exit