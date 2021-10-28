#include <errno.h>

int
get_errno(void)
{
	return errno;
}

void
set_errno(int en)
{
	errno = en;
}
