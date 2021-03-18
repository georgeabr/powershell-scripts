# show a dialog box to rename PC to something meaningful (Joanne's laptop); add this computer to the TeamViewer PC list.

# start-process -Wait msiexec -ArgumentList "/i `"TeamViewer_Host.msi`" /qn CUSTOMCONFIGID=yzvjkgn APITOKEN=11536339-GUVJo4ZMhiV9VErAC1xZ ASSIGNMENTOPTIONS=`"--grant-easy-access --alias `'$env:COMPUTERNAME (my computer) `' `"  "

#ASSIGNMENTOPTIONS=--grant-easy-access --alias `"$env:COMPUTERNAME (my computer) `"
#ASSIGNMENTOPTIONS=`"--grant-easy-access --alias `"$env:COMPUTERNAME (my computer) `" `"

# below works !!!
# start-process -Wait msiexec -ArgumentList "/i `"C:\Users\nfrn\Downloads\TeamViewer_Host.msi`" /passive CUSTOMCONFIGID=yzvjkgn APITOKEN=11536339-GUVJo4ZMhiV9VErAC1xZ ASSIGNMENTOPTIONS=`"--grant-easy-access --alias `"`"$env:COMPUTERNAME (my computer) `"`" `"  "
# =" --group ""Test group"" "

# this works too
# $PCDescription = "this computer"
# start-process -Wait msiexec -ArgumentList "/i `"C:\kits\TeamViewer-Host\TeamViewer_Host.msi`" /qn CUSTOMCONFIGID=yzvjkgn APITOKEN=11536339-GUVJo4ZMhiV9VErAC1xZ ASSIGNMENTOPTIONS=`"--grant-easy-access --alias `"`"$env:COMPUTERNAME ($PCDescription) `"`" `"  "

# next phase, with dialog box
function getValues($formTitle, $textTitle){
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

    $objForm = New-Object System.Windows.Forms.Form
    $objForm.Text = $formTitle
    $objForm.Size = New-Object System.Drawing.Size(500,200)
    $objForm.StartPosition = "CenterScreen"

    $objForm.KeyPreview = $True
    # aha
    $objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") {$Script:userInput=$objTextBox.Text;$x=$objTextBox.Text;$objForm.Close()}})
    # $objForm.Add_KeyDown({if ($_.KeyCode -ne "Enter") {$x=$objTextBox.Text;$objForm.Close()}})
    $objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") {$x=$objTextBox.Text;$objForm.Close()}})

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(260,94)
    $OKButton.Size = New-Object System.Drawing.Size(90,26)
    $OKButton.Text = "OK"
    $OKButton.Add_Click({$Script:userInput=$objTextBox.Text;$objForm.Close()})
    $objForm.Controls.Add($OKButton)

    $CANCELButton = New-Object System.Windows.Forms.Button
    $CANCELButton.Location = New-Object System.Drawing.Size(360,94)
    $CANCELButton.Size = New-Object System.Drawing.Size(90,26)
    $CANCELButton.Text = "Cancel"
    $CANCELButton.Add_Click({$objForm.Close()})
    $objForm.Controls.Add($CANCELButton)

    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,20)
    $objLabel.Size = New-Object System.Drawing.Size(480,60)
    $objLabel.Text = $textTitle
    $objLabel.Font = New-Object System.Drawing.Font("Arial",9,[System.Drawing.FontStyle]::Regular)
    $objLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter 

    $objForm.Controls.Add($objLabel)

    $objTextBox = New-Object System.Windows.Forms.TextBox
    $objTextBox.Location = New-Object System.Drawing.Size(10,93)
    $objTextBox.Size = New-Object System.Drawing.Size(220,0)
    $objTextBox.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Regular)
    $objForm.Controls.Add($objTextBox)

    $objForm.Topmost = $True

    $objForm.Add_Shown({$objForm.Activate(); $objTextBox.focus()})

    # $objForm.Add_Shown({$objForm.Activate()})

    [void] $objForm.ShowDialog()

    return $userInput
}

# $PCDescription =""
$PCDescription = getValues "Who is using this computer?" "Enter computer description, for Teamviewer identification.`nFor example, Anne Baxter's laptop.`nCancel or no values will append (no description) to S/N."
if (!$PCDescription) { $PCDescription = "no description" }
Write-Output $schema

$PCDescriptionJoin = -join("(", $PCDescription, ")")
Write-Output $PCDescriptionJoin
start-process -Wait msiexec -ArgumentList "/i `"C:\kits\TeamViewer-Host\TeamViewer_Host.msi`" /passive CUSTOMCONFIGID=yzvjkgn APITOKEN=11536339-GUVJo4ZMhiV9VErAC1xZ ASSIGNMENTOPTIONS=`"--grant-easy-access --alias `"`"$env:COMPUTERNAME $PCDescriptionJoin `"`" `"  "
