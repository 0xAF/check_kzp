# check_kzp
Check mails against Bulgarian KZP Register

Провери списък с е-мейл адреси за регистрация в КЗП (Комисия за Защита на Потребителя)

perl


---

To check your mails against the already downloaded KZP file:
```
check_kzp.pl mails_file.txt kzp_file.txt
```

To download the latest file from KZP and check your mails:
```
check_kzp.pl mails_file.txt
```


The script will output to STDOUT the resulting cleared (good-to-go) mails and to STDERR the mails which has been cleared (bad-to-send).

example usage:
```
check_kzp.pl mails_file.txt > mails_cleared.txt 2> mails_do_not_send.txt
```

