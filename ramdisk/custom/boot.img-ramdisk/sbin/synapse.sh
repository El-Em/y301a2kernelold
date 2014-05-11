#!/sbin/busybox sh

mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

/sbin/uci

if [ -d /system/etc/init.d ]; then
	/sbin/busybox run-parts /system/etc/init.d
fi;

/sbin/busybox mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system
