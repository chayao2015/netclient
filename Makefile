CFLAGS   = -g -fno-strict-aliasing -Wall -std=c++0x
LDFLAGS  = -llua 
INCLUDE  = -I./

uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
ifeq ($(uname_S),Linux)
	LDFLAGS += -ldl -lpthread
	DEFINE  += -D_LINUX
endif

ifeq ($(uname_S),FreeBSD)
	LDFLAGS += -lexecinfo -lpthread
	DEFINE  += -D_BSD
endif

ifeq ($(uname_S),MINGW32_NT-6.1)
	LDFLAGS += -lws2_32
	DEFINE  += -D_WIN
endif

source   =\
main.cpp\
SysTime.cpp\
LuaPacket.cpp\
NetLua.cpp\
Reactor.cpp\
RPacket.cpp\
CmdRPacket.cpp\
Socket.cpp


all:$(source)
	g++ $(SHARED) $(CFLAGS) -c $(source) $(DEFINE) $(INCLUDE)
	g++ $(SHARED) $(CFLAGS) -o LuaNet *.o $(LDFLAGS)
	rm *.o