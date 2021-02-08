#!/usr/bin/python
import sys,os,os.path,argparse

##########################################################################
##########################################################################

def word(lsb,msb): return lsb<<0|msb<<8

##########################################################################
##########################################################################

def exmon2(options):
    with open(options.exmon2_rom_path,'rb') as f: data=[ord(c) for c in f.read()]

    def get(addr): return data[addr&0x3fff]
    
    if getattr(options,'8346'):
        index=0
        for offset in range(0x8346,0x837e,2):
            addr=word(get(offset+1),
                      get(offset+0))+1
            print '- %02x :: $%04x'%(index,addr)
            index+=1

    if getattr(options,'85fe'):
        for index in range(5):
            addr=word(get(0x85fe+index),
                      get(0x8603+index))
            print '- %02x :: $%04x'%(index,addr)

    if getattr(options,'85d6'):
        # BASIC ROM entry points
        ver_names=['BASIC I',
                   'BASIC II',
                   'BASIC 4',
                   'BASIC 400',
                   'BASIC 4r32']
        width=max([len(x) for x in ver_names])
        for index in range(4):
            base=0x85d7+index*10
            print 'X=$%02X:'%(index*10)
            for ver in range(5):
                addr=word(get(base+0+ver),
                          get(base+5+ver))
                print '    %-*s: $%04x'%(width,
                                         ver_names[ver],
                                         addr)

    if getattr(options,'9443'):
        # instruction mnemonics
        for addr in range(0x9443,0x9483):
            offset=get(addr)
            assert offset>=0 and offset<0x9410-0x937f-2
            maddr=0x937f+offset
            mnemonic=chr(get(maddr+0))+chr(get(maddr+1))+chr(get(maddr+2))
            print '%3u ($%02x): %s'%(addr-0x9443,addr-0x9443,mnemonic)

    if options.mnemonics:
        for addr in range(0x9443,0x9483):
            offset=get(addr)
            assert offset>=0 and offset<0x9410-0x937f-2
            maddr=0x937f+offset
            mnemonic=chr(get(maddr+0))+chr(get(maddr+1))+chr(get(maddr+2))
            print '    .byte mnemonics.%s-mnemonics'%mnemonic
            # print '%3u ($%02x): %s'%(addr-0x9443,addr-0x9443,mnemonic)

    if options.dis:
        # mnemonic for each instruction
        for opcode in range(256):
            mnemonic_index=get(0x9592+opcode)
            value2=get(0x9492+opcode)
            if mnemonic_index==0xff:
                nmos='???'
                cmos='???'
                addr=''
                assert value2==0xff
                size=0
                mode_str='N/A'
            else:
                moffset=get(0x9443+(mnemonic_index&0x7f))
                maddr=0x937f+moffset
                mnemonic=chr(get(maddr+0))+chr(get(maddr+1))+chr(get(maddr+2))
                if mnemonic_index&0x80:
                    nmos='???'
                    cmos=mnemonic
                else:
                    nmos=mnemonic
                    cmos=mnemonic

                mode=get(0x9483+value2)
                mode_str='$%02x'%mode
                aaddr=0x9410+(mode&0x3f)
                size=mode>>6
                addr=''
                while True:
                    c=get(aaddr)
                    if c==0: break
                    addr+=chr(c)
                    aaddr+=1
                    
            print '$%02x: %3u ($%04x): NMOS=%s CMOS=%s %3u $%04x \"%s\" +%d %s'%(opcode,mnemonic_index,mnemonic_index,nmos,cmos,value2,value2,addr,size,mode_str)

##########################################################################
##########################################################################

def main(argv):
    parser=argparse.ArgumentParser()

    def table(addr): parser.add_argument('--%04x'%addr,action='store_true',help='dump info about table at $%04x'%addr)
    table(0x8346)
    table(0x85fe)
    table(0x85d6)
    table(0x9443)

    parser.add_argument('--mnemonics',action='store_true',help='dump symbolized mnemonics table')

    parser.add_argument('--dis',action='store_true',help='dump disassembly tables')

    parser.add_argument('exmon2_rom_path',nargs='?',default='./orig/exmon2-2.02.rom',metavar='FILE',help='read Exmon II ROM from %(metavar)s. Default: %(default)s')

    exmon2(parser.parse_args(argv))

##########################################################################
##########################################################################

if __name__=='__main__': main(sys.argv[1:])
