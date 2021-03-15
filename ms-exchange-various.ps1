# MS Exchange = get a list of emails sent to someone, filter for keyword in subject:
Get-MessageTrackingLog -Recipients xxx@yahoo.co.uk,xxx1@yahoo.com -Start "2/1/2021 8:00AM" -End "2/25/2021 8:00AM" |Select EventId,Timestamp,Sender,Recipients,MessageSubject | ft -Wrap -Autosize | out-file .\emails.txt
Get-MessageTrackingLog -Recipients xxx@test.org.uk -Start "11/18/2020 8:00AM" -End "11/20/2020 8:00AM" -MessageSubject "zoom"|Select EventId,Timestamp,Sender,Recipients,MessageSubject | ft | Out-String -Width 300 | out-file .\emails.txt
