#!/bin/bash
# Panel 
PW=250
PH=48
PX=683
PY=384

echo "%{c}  %{A:p:}Shutdown%{A}  %{A:r:}Reboot%{A}  %{A:s:}Suspend%{A}  %{A:b:}Exit%{A}  " | lemonbar -g ${PW}x${PH}+${PX}+${PY} -dp | \
	    while :; do
		            read line
			            case $line in 
					                'b')
								                p=$(pgrep -n lemonbar)
										                kill $p 
												                exit 
														                ;;
																            's')
																		                    systemctl suspend &
																				                    p=$(pgrep -n lemonbar)
																						                    kill $p 
																								                    exit                
																										                    ;;
																												                'p')
																															                systemctl poweroff
																																	                exit
																																			                ;;
																																					            'r')
																																							                    systemctl reboot
																																									                    exit
																																											                    ;;
																																													            esac
																																														        done
