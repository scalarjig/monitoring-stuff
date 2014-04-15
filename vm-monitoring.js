var exec = require('child_process').exec;

exec("vmstat 1 2 |grep -v '^procs'|grep -v 'r'", function (error, stdout, stderr) {
    console.log(stdout);
});