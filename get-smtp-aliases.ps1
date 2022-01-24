# Create an object to hold the results
$addresses = @()
# Get every mailbox in the Exchange Organisation
$Mailboxes = Get-Mailbox -Identity email@example.com -ResultSize Unlimited
 
# Recurse through the mailboxes
ForEach ($mbx in $Mailboxes) {
    # Recurse through every address assigned to the mailbox
    Foreach ($address in $mbx.EmailAddresses) {
        # If it starts with "SMTP:" then it's an email address. Record it
        if ($address.ToString().ToLower().StartsWith("smtp:")) {
            # This is an email address. Add it to the list
            $obj = "" | Select-Object Alias,EmailAddress
            $obj.Alias = $mbx.Alias
            $obj.EmailAddress = $address.ToString().SubString(5)
            $addresses += $obj
        }
    }
}
# Export the final object to a csv in the working directory
$addresses | Export-Csv addresses-online.csv -NoTypeInformation
