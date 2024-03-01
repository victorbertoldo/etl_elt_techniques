# Practice exercises

1.  Problem:

> _List tasks for the DAG `example_branch_labels`._

Click here for Hint

> Use `list` option.

Click here for Solution

```shell
airflow tasks list example_branch_labels
```

2.  Problem:

> _Unpause the DAG `example_branch_labels`._

Click here for Hint

> Use the unpause option.

Click here for Solution

```shell
airflow dags unpause example_branch_labels
```


3.  Problem:

> _Pause the DAG `example_branch_labels`._

Click here for Hint

> Use the pause option.

Click here for Solution

```shell
airflow dags pause example_branch_labels
```





# Exercise 3 - Explore the anatomy of a DAG

An Apache Airflow DAG is a python program. It consists of these logical blocks.

-   Imports
-   DAG Arguments
-   DAG Definition
-   Task Definitions
-   Task Pipeline

A typical `imports` block looks like this.

```python
# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago
```

A typical `DAG Arguments` block looks like this.

```python
#defining DAG arguments
# You can override them on a per-task basis during operator initialization
default_args = {
 'owner': 'Ramesh Sannareddy',
 'start_date': days_ago(0),
 'email': ['ramesh@somemail.com'],
 'email_on_failure': True,
 'email_on_retry': True,
  'retries': 1,
  'retry_delay': timedelta(minutes=5),
 }
```

DAG arguments are like settings for the DAG.

The above settings mention

-   the owner name,
-   when this DAG should run from: days\_age(0) means today,
-   the email address where the alerts are sent to,
-   whether alert must be sent on failure,
-   whether alert must be sent on retry,
-   the number of retries in case of failure, and
-   the time delay between retries.

A typical `DAG definition` block looks like this.

```python
# define the DAG
dag = DAG(
 dag_id='sample-etl-dag',
 default_args=default_args,
 description='Sample ETL DAG using Bash',
 schedule_interval=timedelta(days=1),
)
```


Here we are creating a variable named dag by instantiating the DAG class with the following parameters.

`sample-etl-dag` is the ID of the DAG. This is what you see on the web console.

We are passing the dictionary `default_args`, in which all the defaults are defined.

`description` helps us in understanding what this DAG does.

`schedule_interval` tells us how frequently this DAG runs. In this case every day. (`days=1`).

A typical `task definitions` block looks like this:

```python
# define the tasks`
# define the first task named extract`
extract = BashOperator(
    task_id='extract',
    bash_command='echo "extract"',
    dag=dag,
)
# define the second task named transform
transform = BashOperator(
    task_id='transform',
    bash_command='echo "transform"',
    dag=dag,
)
# define the third task named load
load = BashOperator(
    task_id='load',
    bash_command='echo "load"',
    dag=dag,
)
```


A task is defined using:

-   A task\_id which is a string and helps in identifying the task.
-   What bash command it represents.
-   Which dag this task belongs to.

A typical `task pipeline` block looks like this:

```python
# task pipeline
extract >> transform >> load
```


Task pipeline helps us to organize the order of tasks.

Here the task `extract` must run first, followed by `transform`, followed by the task `load`.

# Exercise 4 - Create a DAG

Let us create a DAG that runs daily, and extracts user information from _/etc/passwd_ file, transforms it, and loads it into a file.

This DAG has two tasks `extract` that extracts fields from _/etc/passwd_ file and `transform_and_load` that transforms and loads data into a file.

```python
# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago
#defining DAG arguments
# You can override them on a per-task basis during operator initialization
default_args = {
 'owner': 'Ramesh Sannareddy',
 'start_date': days_ago(0),
 'email': ['ramesh@somemail.com'],
 'email_on_failure': False,
 'email_on_retry': False,
 'retries': 1,
 'retry_delay': timedelta(minutes=5),
}

# defining the DAG
# define the DAG
dag = DAG(
 'my-first-dag',
 default_args=default_args,
 description='My first DAG',
 schedule_interval=timedelta(days=1),
)
# define the tasks
# define the first task
extract = BashOperator(
 task_id='extract',
 bash_command='cut -d":" -f1,3,6 /etc/passwd > /home/project/airflow/dags/extracted-data.txt',
 dag=dag,
)

# define the second task
transform_and_load = BashOperator(
 task_id='transform',
 bash_command='tr ":" "," < /home/project/airflow/dags/extracted-data.txt > /home/project/airflow/dags/transformed-data.csv',
 dag=dag,
)

# task pipeline
extract >> transform_and_load
```

Create a new file by choosing File->New File and name it `my_first_dag.py`. Copy the code above and paste it into `my_first_dag.py`.


# Exercise 4 - Create a DAG

Let us create a DAG that runs daily, and extracts user information from _/etc/passwd_ file, transforms it, and loads it into a file.

This DAG has two tasks `extract` that extracts fields from _/etc/passwd_ file and `transform_and_load` that transforms and loads data into a file.

```python
# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments
# You can override them on a per-task basis during operator initialization
default_args = {
 'owner': 'Ramesh Sannareddy',
 'start_date': days_ago(0),
 'email': ['ramesh@somemail.com'],
 'email_on_failure': False,
   'email_on_retry': False,
   'retries': 1,
   'retry_delay': timedelta(minutes=5),
  }
# defining the DAG
# define the DAG
dag = DAG(
 'my-first-dag',
 default_args=default_args,
 description='My first DAG',
 schedule_interval=timedelta(days=1),
)
# define the tasks
# define the first task

extract = BashOperator(
 task_id='extract',
 bash_command='cut -d":" -f1,3,6 /etc/passwd > /home/project/airflow/dags/extracted-data.txt',
 dag=dag,
)
# define the second task
transform_and_load = BashOperator(
 task_id='transform',
 bash_command='tr ":" "," < /home/project/airflow/dags/extracted-data.txt > /home/project/airflow/dags/transformed-data.csv',
 dag=dag,
)

# task pipeline
extract >> transform_and_load
```

Create a new file by choosing File->New File and name it `my_first_dag.py`. Copy the code above and paste it into `my_first_dag.py`.


# Exercise 5 - Submit a DAG

Submitting a DAG is as simple as copying the DAG python file into `dags` folder in the `AIRFLOW_HOME` directory.

Airflow searches for Python source files within the specified `DAGS_FOLDER`. The location of `DAGS_FOLDER` can be located in the airflow.cfg file, where it has been configured as `/home/project/airflow/dags`.

![](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/Screenshot%202023-11-21%20182008.png)

Airflow will load the Python source files from this designated location. It will process each file, execute its contents, and subsequently load any DAG objects present in the file.

Therefore, when submitting a `DAG`, it is essential to position it within this directory structure. Alternatively, the `AIRFLOW_HOME` directory, representing the structure `/home/project/airflow`, can also be utilized for DAG submission.

![](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/Screenshot%202023-11-21%20190823.png)

Open a terminal and run the command below to submit the DAG that was created in the previous exercise.

**Note:** While submitting the dag that was created in the previous exercise, use **sudo** in the terminal before the command used to submit the dag.


1.   `cp my_first_dag.py $AIRFLOW_HOME/dags`


Verify that our DAG actually got submitted.

Run the command below to list out all the existing DAGs.



1.  `airflow dags list`


Verify that `my-first-dag` is a part of the output.



1.  `airflow dags list|grep "my-first-dag"`


You should see your DAG name in the output.

Run the command below to list out all the tasks in `my-first-dag`.



1.  `airflow tasks list my-first-dag`


You should see 2 tasks in the output.



# Practice exercises

1.  Problem:

> _Write a DAG named `ETL_Server_Access_Log_Processing`._

_**Task 1**: Create the imports block._  
  
_**Task 2**: Create the DAG Arguments block. You can use the default settings_  
  
_**Task 3**: Create the DAG definition block. The DAG should run daily._  
  
_**Task 4**: Create the download task._  
  
download task must download the server access log file which is available at the URL: [https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt)

_**Task 5**: Create the extract task._  
  
The server access log file contains these fields.

a. `timestamp` \- TIMESTAMP  
  
b. `latitude` \- float  
  
c. `longitude` \- float  
  
d. `visitorid` \- char(37)  
  
e. `accessed_from_mobile` \- boolean  
  
f. `browser_code` \- int  

The `extract` task must extract the fields `timestamp` and `visitorid`.

_**Task 6**: Create the transform task._  
  
The `transform` task must capitalize the `visitorid`.

_**Task 7**: Create the load task._  
  
The `load` task must compress the extracted and transformed data.

_**Task 8**: Create the task pipeline block._  
  
The pipeline block should schedule the task in the order listed below:

1.  download
2.  extract
3.  transform
4.  load

_**Task 10**: Submit the DAG._  
  
_**Task 11**. Verify if the DAG is submitted_  

Click here for Hint

> Follow the example Python code given in the lab and make necessary changes to create the new DAG.

Click here for Solution

Select File -> New File from the menu and name it as `ETL_Server_Access_Log_Processing.py`.  

Add to the file the following parts of code to complete the tasks given in the problem.

_**Task 1: Create the imports block.**_  


```python
# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago
```

_**Task 2: Create the DAG Arguments block. You can use the default settings.**_  


```python

1.  `#defining DAG arguments`

3.  `# You can override them on a per-task basis during operator initialization`
4.  `default_args = {`
5.   `'owner': 'Ramesh Sannareddy',`
6.   `'start_date': days_ago(0),`
7.   `'email': ['ramesh@somemail.com'],`
8.   `'email_on_failure': False,`
9.   `'email_on_retry': False,`
10.   `'retries': 1,`
11.   `'retry_delay': timedelta(minutes=5),`
12.  `}`


_**Task 3: Create the DAG definition block. The DAG should run daily.**_  

1.  1
2.  2
3.  3
4.  4
5.  5
6.  6
7.  7
8.  8
9.  9

1.  `# defining the DAG`

3.  `# define the DAG`
4.  `dag = DAG(`
5.   `'ETL_Server_Access_Log_Processing',`
6.   `default_args=default_args,`
7.   `description='My first DAG',`
8.   `schedule_interval=timedelta(days=1),`
9.  `)`


_**Task 4: Create the download task.**_  

1.  1
2.  2
3.  3
4.  4
5.  5
6.  6
7.  7
8.  8
9.  9

1.  `# define the tasks`

3.  `# define the task 'download'`

5.  `download = BashOperator(`
6.   `task_id='download',`
7.   `bash_command='wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt"',`
8.   `dag=dag,`
9.  `)`


_**Task 5: Create the extract task.**_  

The extract task must extract the fields `timestamp` and `visitorid`.

1.  1
2.  2
3.  3
4.  4
5.  5
6.  6
7.  7

1.  `# define the task 'extract'`

3.  `extract = BashOperator(`
4.   `task_id='extract',`
5.   `bash_command='cut -f1,4 -d"#" web-server-access-log.txt > /home/project/airflow/dags/extracted.txt',`
6.   `dag=dag,`
7.  `)`


_**Task 6: Create the transform task.**_  
The transform task must capitalize the `visitorid`.

1.  1
2.  2
3.  3
4.  4
5.  5
6.  6
7.  7

1.  `# define the task 'transform'`

3.  `transform = BashOperator(`
4.   `task_id='transform',`
5.   `bash_command='tr "[a-z]" "[A-Z]" < /home/project/airflow/dags/extracted.txt > /home/project/airflow/dags/capitalized.txt',`
6.   `dag=dag,`
7.  `)`


_**Task 7: Create the load task.**_  
The `load` task must compress the extracted and transformed data.

1.  1
2.  2
3.  3
4.  4
5.  5
6.  6
7.  7

1.  `# define the task 'load'`

3.  `load = BashOperator(`
4.   `task_id='load',`
5.   `bash_command='zip log.zip capitalized.txt' ,`
6.   `dag=dag,`
7.  `)`


_**Task 8: Create the task pipeline block.**_  

1.  1
2.  2
3.  3

1.  `# task pipeline`

3.  `download >> extract >> transform >> load`


_**Task 9: Submit the DAG.**_  

1.  1

1.   `cp  ETL_Server_Access_Log_Processing.py $AIRFLOW_HOME/dags`


_**Task 10: Verify if the DAG is submitted.**_  

1.  1

1.  `airflow dags list`


Verify that the DAG’s Python script  `ETL_Server_Access_Log_Processing.py` is listed.
