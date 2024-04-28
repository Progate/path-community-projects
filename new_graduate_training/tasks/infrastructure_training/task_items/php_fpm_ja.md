## PHPをphp-fpmで動かしてみよう

### Apacheを止めてみよう

まずは、現在の Apache の状態を確認しましょう。起動していることがわかります。

```terminal
$ sudo systemctl status apache2
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor prese>
     Active: active (running) since Fri 2024-03-29 05:30:27 UTC; 1h 14min ago
       Docs: https://httpd.apache.org/docs/2.4/
   Main PID: 9678 (apache2)
      Tasks: 6 (limit: 517)
     Memory: 10.1M
        CPU: 263ms
     CGroup: /system.slice/apache2.service
             ├─9678 /usr/sbin/apache2 -k start
             ├─9680 /usr/sbin/apache2 -k start
             ├─9681 /usr/sbin/apache2 -k start
             ├─9682 /usr/sbin/apache2 -k start
             ├─9683 /usr/sbin/apache2 -k start
             └─9684 /usr/sbin/apache2 -k start

Mar 29 05:30:27 ip-172-31-36-76 systemd[1]: Starting The Apache HTTP Server...
Mar 29 05:30:27 ip-172-31-36-76 systemd[1]: Started The Apache HTTP Server.
```

Apache を止めるには、`systemctl` コマンドを使います。

```terminal
$ sudo systemctl stop apache2
```

Apache が停止したか確認しましょう。

```terminal
$ sudo systemctl status apache2
○ apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset>
     Active: inactive (dead) since Fri 2024-03-29 07:04:30 UTC; 5s ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 18706 ExecStop=/usr/sbin/apachectl graceful-stop (code=exited, stat>
   Main PID: 9678 (code=exited, status=0/SUCCESS)
        CPU: 389ms

Mar 29 05:30:27 ip-172-31-36-76 systemd[1]: Starting The Apache HTTP Server...
```

使えるコマンドは下記のとおりです。

```terminal
# apache2の状態を見る
$ sudo systemctl status apache2

# apache2を再起動
$ sudo systemctl restart apache2

# apache2の設定を再読み込み
$ sudo systemctl reload apache2

# apache2を止める
$ sudo systemctl stop apache2

# マシンを再起動したときに apache2 を自動起動する
$ sudo systemctl enable apache2

# マシンを再起動したときに apache2 を自動起動しないようにする
$ sudo systemctl disable apache2
```

### aptでphp8.1-fpmをインストールしてみよう

PHP 8.1 の FastCGI プロセスマネージャ（php-fpm）をインストールします。

```terminal
$ sudo apt install php8.1-fpm
```

インストール時に下記のような画面が表示される場合があるので、デフォルトの選択肢で OK します。

- <img width="580" alt="image" src="https://github.com/Progate/path-community-projects/assets/26600620/5e8edd66-e2aa-4ae3-80b3-604831bde64b">
- <img width="580" alt="image" src="https://github.com/Progate/path-community-projects/assets/26600620/c3bec52a-9c8c-472f-82b9-d85cda042d1d">

### php-fpmの状態を確認してみよう

`sudo systemctl status php8.1-fpm` コマンドを使って、`php-fpm` の状態を確認します。

```terminal
$ sudo systemctl status php8.1-fpm
● php8.1-fpm.service - The PHP 8.1 FastCGI Process Manager
     Loaded: loaded (/lib/systemd/system/php8.1-fpm.service; enabled; vendor pre>
     Active: active (running) since Fri 2024-03-29 07:13:52 UTC; 11s ago
       Docs: man:php-fpm8.1(8)
    Process: 22935 ExecStartPost=/usr/lib/php/php-fpm-socket-helper install /run>
   Main PID: 22932 (php-fpm8.1)
     Status: "Processes active: 0, idle: 2, Requests: 0, slow: 0, Traffic: 0req/>
      Tasks: 3 (limit: 517)
     Memory: 7.2M
        CPU: 44ms
     CGroup: /system.slice/php8.1-fpm.service
             ├─22932 "php-fpm: master process (/etc/php/8.1/fpm/php-fpm.conf)" ">
             ├─22933 "php-fpm: pool www" "" "" "" "" "" "" "" "" "" "" "" "" "" >
             └─22934 "php-fpm: pool www" "" "" "" "" "" "" "" "" "" "" "" "" "" >

Mar 29 07:13:52 ip-172-31-36-76 systemd[1]: php8.1-fpm.service: Deactivated succ>
Mar 29 07:13:52 ip-172-31-36-76 systemd[1]: Stopped The PHP 8.1 FastCGI Process >
Mar 29 07:13:52 ip-172-31-36-76 systemd[1]: Starting The PHP 8.1 FastCGI Process>
Mar 29 07:13:52 ip-172-31-36-76 systemd[1]: Started The PHP 8.1 FastCGI Proces
```

### php-fpmのプロセスはいくつ起動してる？

出力によると、`php8.1-fpm` サービスにはメインのプロセス（マスタープロセス）が 1 つと、`pool www` として実行されている子プロセスが 2 つあります。したがって、合計で 3 つのプロセスが起動しています。これは、`CGroup` セクションに表示されている以下の行から確認できます。

```sh
             ├─22932 "php-fpm: master process (/etc/php/8.1/fpm/php-fpm.conf)" ">
             ├─22933 "php-fpm: pool www" "" "" "" "" "" "" "" "" "" "" "" "" "" >
             └─22934 "php-fpm: pool www" "" "" "" "" "" "" "" "" "" "" "" "" "" >
```

### php-fpm の設定ファイルはどこにある？

`php-fpm` の設定ファイルのパスは、マスタープロセスの記述に明示的に記載されています。これは `/etc/php/8.1/fpm/php-fpm.conf` です。これが `php-fpm` のメインの設定ファイルであり、`php-fpm` の動作やプール設定などをカスタマイズする際に編集します。

```sh
             ├─22932 "php-fpm: master process (/etc/php/8.1/fpm/php-fpm.conf)" ">
```

このパスから、PHP 8.1 用の `php-fpm` の設定ファイルが `/etc/php/8.1/fpm/` ディレクトリ内にあり、ファイル名は `php-fpm.conf` であることがわかります。この情報をもとに、必要に応じて `php-fpm` の設定を調整できます。

### 設定ファイルを開いてみよう

確認した設定ファイルを開いてみましょう。

```terminal
$ cat /etc/php/8.1/fpm/php-fpm.conf
;;;;;;;;;;;;;;;;;;;;;
; FPM Configuration ;
;;;;;;;;;;;;;;;;;;;;;

; All relative paths in this configuration file are relative to PHP's install
; prefix (/usr). This prefix can be dynamically changed by using the
; '-p' argument from the command line.

;;;;;;;;;;;;;;;;;;
; Global Options ;
;;;;;;;;;;;;;;;;;;

[global]
; Pid file
; Note: the default prefix is /var
; Default Value: none
; Warning: if you change the value here, you need to modify systemd
; service PIDFile= setting to match the value here.
pid = /run/php/php8.1-fpm.pid

; Error log file
; If it's set to "syslog", log is sent to syslogd instead of being written
; into a local file.
; Note: the default prefix is /var
; Default Value: log/php-fpm.log
error_log = /var/log/php8.1-fpm.log

; syslog_facility is used to specify what type of program is logging the
; message. This lets syslogd specify that messages from different facilities
; will be handled differently.
; See syslog(3) for possible values (ex daemon equiv LOG_DAEMON)
; Default Value: daemon
;syslog.facility = daemon

; syslog_ident is prepended to every message. If you have multiple FPM
; instances running on the same server, you can change the default value
; which must suit common needs.
; Default Value: php-fpm
;syslog.ident = php-fpm

; Log level
; Possible Values: alert, error, warning, notice, debug
; Default Value: notice
;log_level = notice

; Log limit on number of characters in the single line (log entry). If the
; line is over the limit, it is wrapped on multiple lines. The limit is for
; all logged characters including message prefix and suffix if present. However
; the new line character does not count into it as it is present only when
; logging to a file descriptor. It means the new line character is not present
; when logging to syslog.
; Default Value: 1024
;log_limit = 4096

; Log buffering specifies if the log line is buffered which means that the
; line is written in a single write operation. If the value is false, then the
; data is written directly into the file descriptor. It is an experimental
; option that can potentially improve logging performance and memory usage
; for some heavy logging scenarios. This option is ignored if logging to syslog
; as it has to be always buffered.
; Default value: yes
;log_buffering = no

; If this number of child processes exit with SIGSEGV or SIGBUS within the time
; interval set by emergency_restart_interval then FPM will restart. A value
; of '0' means 'Off'.
; Default Value: 0
;emergency_restart_threshold = 0

; Interval of time used by emergency_restart_interval to determine when
; a graceful restart will be initiated.  This can be useful to work around
; accidental corruptions in an accelerator's shared memory.
; Available Units: s(econds), m(inutes), h(ours), or d(ays)
; Default Unit: seconds
; Default Value: 0
;emergency_restart_interval = 0

; Time limit for child processes to wait for a reaction on signals from master.
; Available units: s(econds), m(inutes), h(ours), or d(ays)
; Default Unit: seconds
; Default Value: 0
;process_control_timeout = 0

; The maximum number of processes FPM will fork. This has been designed to control
; the global number of processes when using dynamic PM within a lot of pools.
; Use it with caution.
; Note: A value of 0 indicates no limit
; Default Value: 0
; process.max = 128

; Specify the nice(2) priority to apply to the master process (only if set)
; The value can vary from -19 (highest priority) to 20 (lowest priority)
; Note: - It will only work if the FPM master process is launched as root
;       - The pool process will inherit the master process priority
;         unless specified otherwise
; Default Value: no set
; process.priority = -19

; Send FPM to background. Set to 'no' to keep FPM in foreground for debugging.
; Default Value: yes
;daemonize = yes

; Set open file descriptor rlimit for the master process.
; Default Value: system defined value
;rlimit_files = 1024

; Set max core size rlimit for the master process.
; Possible Values: 'unlimited' or an integer greater or equal to 0
; Default Value: system defined value
;rlimit_core = 0

; Specify the event mechanism FPM will use. The following is available:
; - select     (any POSIX os)
; - poll       (any POSIX os)
; - epoll      (linux >= 2.5.44)
; - kqueue     (FreeBSD >= 4.1, OpenBSD >= 2.9, NetBSD >= 2.0)
; - /dev/poll  (Solaris >= 7)
; - port       (Solaris >= 10)
; Default Value: not set (auto detection)
;events.mechanism = epoll

; When FPM is built with systemd integration, specify the interval,
; in seconds, between health report notification to systemd.
; Set to 0 to disable.
; Available Units: s(econds), m(inutes), h(ours)
; Default Unit: seconds
; Default value: 10
;systemd_interval = 10

;;;;;;;;;;;;;;;;;;;;
; Pool Definitions ;
;;;;;;;;;;;;;;;;;;;;

; Multiple pools of child processes may be started with different listening
; ports and different management options.  The name of the pool will be
; used in logs and stats. There is no limitation on the number of pools which
; FPM can handle. Your system will tell you anyway :)

; Include one or more files. If glob(3) exists, it is used to include a bunch of
; files from a glob(3) pattern. This directive can be used everywhere in the
; file.
; Relative path can also be used. They will be prefixed by:
;  - the global prefix if it's been set (-p argument)
;  - /usr otherwise
include=/etc/php/8.1/fpm/pool.d/*.conf

```

### 質問：php-fpmがlistenしているソケットファイルはどこにある？

この質問は難しいため、わからない場合は内容を読むだけで構いません。

#### ソケットファイルとは？

ソケットファイル（UNIXドメインソケットとも呼ばれる）は、同じマシン上のプロセス間で通信を行うためのエンドポイントです。これは、ネットワークを介さずにデータをやり取りすることができるファイルベースのインターフェースで、特にパフォーマンスを重視するアプリケーションで利用されます。UNIXソケットは、TCP/IPソケットと比較して、オーバーヘッドが少なく、高速な通信が可能です。

#### php-fpmのソケットファイルについて

`php-fpm`（PHP FastCGI Process Manager）は、PHPスクリプトを実行するためにWebサーバー（例えばApacheやNginx）からのリクエストを受け取ります。通常、この通信はTCP/IPポートまたはUNIXドメインソケットを通じて行われます。ソケットファイルを使用することで、WebサーバーとPHPプロセッサ間の通信が効率的に行われるため、多くの設定で採用されています。

この質問は、`php-fpm` がどのソケットファイルを使ってリッスンしているかを特定することに関連しています。具体的な場所は、`php-fpm` のプール設定ファイル (`*.conf`) 内で指定されます。以下は、設定ファイルの探索方法とソケットファイルの位置の確認方法です：

```sh
include=/etc/php/8.1/fpm/pool.d/*.conf
```

このディレクティブは、`/etc/php/8.1/fpm/pool.d/` ディレクトリ内のすべての `.conf` ファイルをインクルードすることを示しています。ソケットファイルの設定は、これらのプール設定ファイルに記述されています。

プール設定ファイルを確認して、`php-fpm` がリッスンしているソケットファイルまたはポートを特定します。以下のコマンドを使って、プール設定ファイルを確認できます。

```terminal
$ ls /etc/php/8.1/fpm/pool.d/
www.conf
$ cat /etc/php/8.1/fpm/pool.d/www.conf | grep "^listen ="
listen = /run/php/php8.1-fpm.sock
```

この設定は、`php-fpm` が UNIX ドメインソケット `/run/php/php8.1-fpm.sock` を使用してリッスンしていることを意味します。ウェブサーバー（Apache や Nginx など）は、PHP コンテンツを処理するためにこのソケットファイル経由で `php-fpm` にリクエストを送信するように設定する必要があります。

以上から、`php-fpm` がリッスンしているソケットファイルの場所は `/run/php/php8.1-fpm.sock` と特定できます。
