## サーバーの状態を見てみよう

EC2 インスタンスに SSH でログインして、サーバーの状態を確認してみましょう。

### プロセスは何個ぐらい起動してる？

以下のコマンドを実行してください。`ps aux` コマンドはシステム上で実行中のすべてのプロセスに関する情報を表示します。

```terminal
$ ps aux

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  2.6 167416 12120 ?        Ss   Mar28   0:05 /sbin/init
root           2  0.0  0.0      0     0 ?        S    Mar28   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   Mar28   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   Mar28   0:00 [rcu_par_gp]
root           5  0.0  0.0      0     0 ?        I<   Mar28   0:00 [slub_flushwq]
root           6  0.0  0.0      0     0 ?        I<   Mar28   0:00 [netns]
root           8  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kworker/0:0H-events_highpri]
root          10  0.0  0.0      0     0 ?        I    Mar28   0:00 [kworker/u30:0-events_power_efficient]
root          11  0.0  0.0      0     0 ?        I<   Mar28   0:00 [mm_percpu_wq]
root          12  0.0  0.0      0     0 ?        I    Mar28   0:00 [rcu_tasks_rude_kthread]
root          13  0.0  0.0      0     0 ?        I    Mar28   0:00 [rcu_tasks_trace_kthread]
root          14  0.0  0.0      0     0 ?        S    Mar28   0:00 [ksoftirqd/0]
root          15  0.0  0.0      0     0 ?        I    Mar28   0:01 [rcu_sched]
root          16  0.0  0.0      0     0 ?        S    Mar28   0:00 [migration/0]
root          17  0.0  0.0      0     0 ?        S    Mar28   0:00 [idle_inject/0]
root          18  0.0  0.0      0     0 ?        S    Mar28   0:00 [cpuhp/0]
root          19  0.0  0.0      0     0 ?        S    Mar28   0:00 [kdevtmpfs]
root          20  0.0  0.0      0     0 ?        I<   Mar28   0:00 [inet_frag_wq]
root          22  0.0  0.0      0     0 ?        S    Mar28   0:00 [kauditd]
root          23  0.0  0.0      0     0 ?        S    Mar28   0:00 [khungtaskd]
root          25  0.0  0.0      0     0 ?        S    Mar28   0:00 [oom_reaper]
root          26  0.0  0.0      0     0 ?        I<   Mar28   0:00 [writeback]
root          27  0.0  0.0      0     0 ?        S    Mar28   0:01 [kcompactd0]
root          28  0.0  0.0      0     0 ?        SN   Mar28   0:00 [ksmd]
root          29  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kintegrityd]
root          30  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kblockd]
root          31  0.0  0.0      0     0 ?        I<   Mar28   0:00 [blkcg_punt_bio]
root          32  0.0  0.0      0     0 ?        S    Mar28   0:00 [xen-balloon]
root          33  0.0  0.0      0     0 ?        I<   Mar28   0:00 [tpm_dev_wq]
root          34  0.0  0.0      0     0 ?        I<   Mar28   0:00 [ata_sff]
root          35  0.0  0.0      0     0 ?        I<   Mar28   0:00 [md]
root          36  0.0  0.0      0     0 ?        I<   Mar28   0:00 [md_bitmap]
root          37  0.0  0.0      0     0 ?        I<   Mar28   0:00 [edac-poller]
root          38  0.0  0.0      0     0 ?        I<   Mar28   0:00 [devfreq_wq]
root          39  0.0  0.0      0     0 ?        S    Mar28   0:00 [watchdogd]
root          42  0.0  0.0      0     0 ?        S    Mar28   0:00 [kswapd0]
root          43  0.0  0.0      0     0 ?        S    Mar28   0:00 [ecryptfs-kthread]
root          44  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kthrotld]
root          45  0.0  0.0      0     0 ?        I<   Mar28   0:00 [acpi_thermal_pm]
root          46  0.0  0.0      0     0 ?        S    Mar28   0:00 [xenbus]
root          47  0.0  0.0      0     0 ?        S    Mar28   0:00 [xenwatch]
root          48  0.0  0.0      0     0 ?        I<   Mar28   0:00 [nvme-wq]
root          49  0.0  0.0      0     0 ?        I<   Mar28   0:00 [nvme-reset-wq]
root          50  0.0  0.0      0     0 ?        I<   Mar28   0:00 [nvme-delete-wq]
root          51  0.0  0.0      0     0 ?        I<   Mar28   0:00 [nvme-auth-wq]
root          52  0.0  0.0      0     0 ?        S    Mar28   0:00 [scsi_eh_0]
root          53  0.0  0.0      0     0 ?        I<   Mar28   0:00 [scsi_tmf_0]
root          54  0.0  0.0      0     0 ?        S    Mar28   0:00 [scsi_eh_1]
root          55  0.0  0.0      0     0 ?        I<   Mar28   0:00 [scsi_tmf_1]
root          56  0.0  0.0      0     0 ?        I<   Mar28   0:00 [mld]
root          57  0.0  0.0      0     0 ?        I<   Mar28   0:00 [ipv6_addrconf]
root          64  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kstrp]
root          66  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kworker/u31:0]
root          70  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kworker/0:2H-kblockd]
root          71  0.0  0.0      0     0 ?        I<   Mar28   0:00 [charger_manager]
root          72  0.0  0.0      0     0 ?        S    Mar28   0:00 [jbd2/xvda1-8]
root          73  0.0  0.0      0     0 ?        I<   Mar28   0:00 [ext4-rsv-conver]
root         111  0.0  3.0  47888 14084 ?        S<s  Mar28   0:00 /lib/systemd/systemd-journald
root         142  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kaluad]
root         144  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kmpath_rdacd]
root         146  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kmpathd]
root         147  0.0  0.0      0     0 ?        I<   Mar28   0:00 [kmpath_handlerd]
root         151  0.0  5.9 289316 27392 ?        SLsl Mar28   0:04 /sbin/multipathd -d -s
root         160  0.0  1.2  11364  5828 ?        Ss   Mar28   0:00 /lib/systemd/systemd-udevd
root         171  0.0  0.0      0     0 ?        I<   Mar28   0:00 [cryptd]
systemd+     314  0.0  1.5  16260  7296 ?        Ss   Mar28   0:00 /lib/systemd/systemd-networkd
systemd+     316  0.0  2.3  25540 10848 ?        Ss   Mar28   0:00 /lib/systemd/systemd-resolved
root         368  0.0  0.4   2816  2048 ?        Ss   Mar28   0:00 /usr/sbin/acpid
root         373  0.0  0.6   7288  2816 ?        Ss   Mar28   0:00 /usr/sbin/cron -f -P
message+     374  0.0  1.0   8656  4864 ?        Ss   Mar28   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile 
_chrony      385  0.0  0.7  18892  3484 ?        S    Mar28   0:01 /usr/sbin/chronyd -F 1
_chrony      387  0.0  0.4  10564  1988 ?        S    Mar28   0:00 /usr/sbin/chronyd -F 1
root         401  0.0  4.0  33084 18676 ?        Ss   Mar28   0:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-tr
syslog       413  0.0  1.2 222404  5632 ?        Ssl  Mar28   0:00 /usr/sbin/rsyslogd -n -iNONE
root         429  0.0  1.5  15540  7296 ?        Ss   Mar28   0:00 /lib/systemd/systemd-logind
root         565  0.0  0.0      0     0 ?        I<   Mar28   0:00 [tls-strp]
root         567  0.0  4.1 110100 19072 ?        Ssl  Mar28   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upg
root         569  0.0  0.5   6220  2304 ttyS0    Ss+  Mar28   0:00 /sbin/agetty -o -p -- \u --keep-baud 115200,57600,38400,9600 t
root         571  0.0  0.4   6176  2176 tty1     Ss+  Mar28   0:00 /sbin/agetty -o -p -- \u --noclear tty1 linux
root         572  0.0  1.5 235448  7304 ?        Ssl  Mar28   0:00 /usr/libexec/polkitd --no-debug
root         658  0.0  1.8  15440  8320 ?        Ss   Mar28   0:00 sshd: /usr/sbin/sshd -D -o AuthorizedKeysCommand /usr/share/ec
root        1079  0.0  2.7 1241300 12380 ?       Ssl  Mar28   0:02 /snap/amazon-ssm-agent/7628/amazon-ssm-agent
root        1322  0.0  0.0      0     0 ?        I    Mar28   0:00 [kworker/u30:1-events_unbound]
root        1388  0.0  0.0      0     0 ?        I    Mar28   0:00 [kworker/0:0-events]
root        1510  0.0  6.8 1319216 31292 ?       Ssl  Mar28   0:04 /usr/lib/snapd/snapd
root        2145  0.0  0.0      0     0 ?        I    00:00   0:00 [kworker/0:1-events]
root        2153  0.0  0.0      0     0 ?        I    00:17   0:00 [kworker/u30:3-events_unbound]
root        2186  0.0  2.3  17056 10752 ?        Ss   05:01   0:00 sshd: ubuntu [priv]
ubuntu      2189  0.0  2.1  16944  9600 ?        Ss   05:01   0:00 /lib/systemd/systemd --user
root        2190  0.0  0.0      0     0 ?        I    05:01   0:00 [kworker/0:2-events]
ubuntu      2191  0.0  1.4 170328  6524 ?        S    05:01   0:00 (sd-pam)
ubuntu      2274  0.0  1.7  17192  7920 ?        S    05:01   0:00 sshd: ubuntu@pts/0
ubuntu      2275  0.0  1.1   9156  5120 pts/0    Ss   05:01   0:00 -bash
root        2286  0.0  0.0      0     0 ?        I    05:01   0:00 [kworker/u30:2-events_unbound]
root        2287  0.0  0.0      0     0 ?        I    05:01   0:00 [kworker/u30:4]
ubuntu      2288  0.0  0.7  10464  3200 pts/0    R+   05:03   0:00 ps aux

```

出力からプロセスの数を数えるには、一般的には `wc -l` コマンドをパイプでつなげて使用します。しかし、`ps aux` の出力の最初の行はヘッダー行なので、実際のプロセス数を得るにはそのヘッダー行を除外する必要があります。

```terminal
$ ps aux | wc -l | awk '{print $1-1}'
95
```

このコマンドは、以下のステップで動作します：

1. `ps aux` で実行中の全プロセスのリストを取得します。
2. `wc -l` で得られたリストの行数（プロセス数 + 1）を数えます。
3. `awk '{print $1-1}'` でヘッダー行を除外するために 1 を減算し、実際のプロセス数を出力します。

コマンドの結果から、95 個のプロセスが起動していることがわかります。

ホスト PC でも同様のコマンドを実行ができます。プロセスの数を確認したり、どのようなプロセスが起動しているか確認してみてください。

### このサーバーのメモリはどのぐらい？そのうちどのぐらい使われてる？

以下のコマンドを実行してください。`top` コマンドはシステム上で実行中のプロセスのリアルタイム情報を表示します。

```terminal
$ top

top - 05:08:20 up 15:46,  1 user,  load average: 0.03, 0.03, 0.00
Tasks:  93 total,   1 running,  92 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    446.0 total,     27.8 free,    142.0 used,    276.2 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    275.4 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                  
   1322 root      20   0       0      0      0 I   0.3   0.0   0:00.33 kworker/u30:1-events_power_efficient                     
   2274 ubuntu    20   0   17192   7920   5632 S   0.3   1.7   0:00.05 sshd                                                     
   2289 ubuntu    20   0   10900   3840   3200 R   0.3   0.8   0:00.11 top                                                      
      1 root      20   0  167416  12120   7640 S   0.0   2.7   0:05.53 systemd                                                  
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd                                                 
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp                                                   
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp                                               
      5 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 slub_flushwq                                             
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 netns                                                    
      8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-events_highpri                               

```

この出力は、サーバーのメモリ使用状況に関する情報を示しています。メモリ使用状況に関する情報は通常、出力の上部に表示されます。以下は、`top` コマンドの出力の一部に関する説明です。

1. **メモリ情報を見る**: `top` の出力では、以下のような行でメモリ使用状況が表示されます。

    - `KiB Mem :` この後に総メモリ、使用中のメモリ、空いているメモリ、バッファに使用されているメモリなどの情報が続きます。
    - `KiB Swap:` スワップ領域の使用状況を表示します。

2. **メモリ使用状況を理解する**:
    - **総メモリ**: システムに搭載されている物理メモリの総量です。
    - **使用中のメモリ**: アプリケーションやシステムプロセスによって現在使用されているメモリ量です。
    - **空いているメモリ**: 使用されていない、即座に利用可能なメモリ量です。
    - **バッファ/キャッシュに使用されているメモリ**: OSが効率的なアクセスのためにディスクにあるデータの中身などを一時的に保存しているメモリ領域です。この部分は必要に応じて他のプロセスによって再利用されることがあります。

`top` コマンドはリアルタイムで更新されるため、メモリ使用状況をリアルタイムで監視できます。また、`top` コマンドは多数のオプションを持っており、特定のプロセスを表示したり、表示方法をカスタマイズできます。

上記の実行結果では、`MiB Mem :    446.0 total,     27.8 free,    142.0 used,    276.2 buff/cache` という行が表示されています。この行から、サーバーのメモリ容量が 446MB で、うち 27.8MB が空いており、142MB が使用されていることがわかります。

### このサーバーのディスク容量はどのぐらい？そのうちどのぐらい使われてる？

下記のコマンドを実行してください。`df -h` コマンドはシステムのディスク使用状況に関する情報を示しています。

```terminal
$ df -h 
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.6G  1.7G  5.9G  23% /
tmpfs           223M     0  223M   0% /dev/shm
tmpfs            90M  844K   89M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda15     105M  6.1M   99M   6% /boot/efi
tmpfs            45M  4.0K   45M   1% /run/user/1000
```

それぞれの列と行が何を意味するのか、順番に解説します。

1. **列の説明**
    - **Filesystem**: 使用されているファイルシステムのデバイスやファイルです。
    - **Size**: ファイルシステムの総容量です。
    - **Used**: 使用されている容量です。
    - **Avail**: 利用可能な容量です。
    - **Use%**: 使用されている容量の割合です。
    - **Mounted on**: ファイルシステムがマウントされているディレクトリです。

2. **行の説明**
    - **/dev/root**: ルートファイルシステムで、7.6GB の容量があります。このうち 1.7GB が使用されており、5.9GB が利用可能です。使用率は 23%です。これはシステムのメインファイルシステムで、ほとんどのプログラムとデータがこの領域に格納されます。
    - **tmpfs**: これはテンポラリファイルストレージのためのメモリ上のファイルシステムです。例えば、`/dev/shm` は共有メモリのために使われ、223MB の容量があり、全く使用されていません（0%の使用率）。`tmpfs` のエントリは主にシステムやアプリケーションによる一時的なデータ保存に使用され、再起動時には内容が消去されます。
    - **/dev/xvda15**: `/boot/efi` ディレクトリにマウントされたファイルシステムで、EFI（Extensible Firmware Interface）の起動に関連したファイルが格納されています。この領域は 105MB の容量があり、6.1MB が使用されていて、99MB が利用可能です。使用率は 6%です。
    - **/run/user/1000**: ユーザー固有のランタイムデータ（例えばセッション情報など）を格納するための一時的なファイルシステムで、45MB の容量があり、ほとんど使用されていません（4.0KB 使用）。

上記の結果から、`7.6G容量  1.7G使用  5.9G空き` という情報が得られます。つまり、このシステムのルートファイルシステムにはまだ十分な空き容量があり（5.9GB 利用可能）、システム全体としてはディスク容量に余裕がある状況であることがわかります。また、EFI パーティションや tmpfs の使用状況も健全です。

### このサーバーに入ってるテキストエディタは何がある？

以下のコマンドを実行してください。`which` コマンドは指定したコマンドのパスを表示します。

```terminal
$ which nano
/usr/bin/nano
$ which vi
/usr/bin/vi
$ which emacs
emacs not found
$ which gedit
emacs not gedit

```

`nano` と `vi` がインストールされていることがわかります。`emacs` と `gedit` はインストールされていないようです。必要に応じてこれらのエディタをインストールできます。

```terminal
$ sudo apt update && sudo apt install emacs
```

### ~/.bashrc を開いてみよう

ターミナル上でエディタを使うことになれていない場合は試しに `vi` コマンドを使ってみましょう。

`~/.bashrc` ファイルは PATH の設定などで重要になりやすいファイルです。

```terminal
$ vi ~/.bashrc
```

`vi` エディタの基本的な使い方は以下の通りです。

- `i` キーを押すと挿入モードになります。このモードで文字を入力できます。
- 挿入モードから抜けるには `ESC` キーを押します。
- 挿入モードから抜けた後、`:wq` と入力して `Enter` キーを押すと保存して終了します。
  - 保存せずに終了する場合は、`:q!` と入力して `Enter` キーを押します。

### 判定のためにサーバー情報を.envファイルに記載しよう

次のステップに進む前に、`.env` ファイルに確認したサーバー情報を記載してください。判定するために使用します。

※これらの値はタスクの手順を進めていく中で変化していきます。現時点の数値を入れておき、タスクの最後でも `.env` ファイルを更新して値の変化を確認してください。

```.env
# プロセスは何個ぐらい起動してる？
ANSWER_CHECK_SERVER_STATUS_PS_COUNT=00

# このサーバーのメモリはどのぐらい？そのうちどのぐらい使われてる？
ANSWER_CHECK_SERVER_STATUS_MEM_TOTAL=000.0
ANSWER_CHECK_SERVER_STATUS_MEM_USED=000.0

# このサーバーのディスク容量はどのぐらい？そのうちどのぐらい使われてる？
ANSWER_CHECK_SERVER_STATUS_DISK_TOTAL="0.0G"
ANSWER_CHECK_SERVER_STATUS_DISK_USED="0.0G"
```
