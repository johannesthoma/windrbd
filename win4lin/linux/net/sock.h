#ifndef _LINUX_NET_SOCK_H
#define _LINUX_NET_SOCK_H

#define SOCK_SNDBUF_LOCK	1
#define SOCK_RCVBUF_LOCK	2

struct sock {
        int sk_sndtimeo;
        int sk_rcvtimeo;
		/* TODO: does not exist on Linux */
        int sk_connecttimeo;

        int sk_state;

	size_t sk_sndbuf;
	size_t sk_rcvbuf;

	int sk_userlocks;
};

#endif

