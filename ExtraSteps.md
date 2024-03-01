# Extra Steps to make it work

### Don`t forget to add execution permitions to the sh file:

```shell
chmod +x temperature_etl.sh
```

### Now schedule the ETL job

```shell
crontab -e
```
To run every minute of every day:

```shell
1 * * * * /path/to/temperature_etl.sh
```

