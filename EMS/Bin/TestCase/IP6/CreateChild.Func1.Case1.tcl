#
# The material contained herein is not a license, either      
# expressly or impliedly, to any intellectual property owned  
# or controlled by any of the authors or developers of this   
# material or to any contribution thereto. The material       
# contained herein is provided on an "AS IS" basis and, to the
# maximum extent permitted by applicable law, this information
# is provided AS IS AND WITH ALL FAULTS, and the authors and  
# developers of this material hereby disclaim all other       
# warranties and conditions, either express, implied or       
# statutory, including, but not limited to, any (if any)      
# implied warranties, duties or conditions of merchantability,
# of fitness for a particular purpose, of accuracy or         
# completeness of responses, of results, of workmanlike       
# effort, of lack of viruses and of lack of negligence, all   
# with regard to this material and any contribution thereto.  
# Designers must not rely on the absence or characteristics of
# any features or instructions marked "reserved" or           
# "undefined." The Unified EFI Forum, Inc. reserves any       
# features or instructions so marked for future definition and
# shall have no responsibility whatsoever for conflicts or    
# incompatibilities arising from future changes to them. ALSO,
# THERE IS NO WARRANTY OR CONDITION OF TITLE, QUIET ENJOYMENT,
# QUIET POSSESSION, CORRESPONDENCE TO DESCRIPTION OR          
# NON-INFRINGEMENT WITH REGARD TO THE TEST SUITE AND ANY      
# CONTRIBUTION THERETO.                                       
#                                                             
# IN NO EVENT WILL ANY AUTHOR OR DEVELOPER OF THIS MATERIAL OR
# ANY CONTRIBUTION THERETO BE LIABLE TO ANY OTHER PARTY FOR   
# THE COST OF PROCURING SUBSTITUTE GOODS OR SERVICES, LOST    
# PROFITS, LOSS OF USE, LOSS OF DATA, OR ANY INCIDENTAL,      
# CONSEQUENTIAL, DIRECT, INDIRECT, OR SPECIAL DAMAGES WHETHER 
# UNDER CONTRACT, TORT, WARRANTY, OR OTHERWISE, ARISING IN ANY
# WAY OUT OF THIS OR ANY OTHER AGREEMENT RELATING TO THIS     
# DOCUMENT, WHETHER OR NOT SUCH PARTY HAD ADVANCE NOTICE OF   
# THE POSSIBILITY OF SUCH DAMAGES.                            
#                                                             
# Copyright 2006, 2007, 2008, 2009, 2010 Unified EFI, Inc. All
# Rights Reserved, subject to all existing rights in all      
# matters included within this Test Suite, to which United    
# EFI, Inc. makes no claim of right.                          
#                                                             
# Copyright (c) 2010, Intel Corporation. All rights reserved.<BR> 
#
#
################################################################################
CaseLevel         FUNCTION
CaseAttribute     AUTO
CaseVerboseLevel  DEFAULT
set reportfile    report.csv

#
# test case Name, category, description, GUID...
#
CaseGuid        1E74CD15-C273-4b77-9096-58A7570B0EAD
CaseName        CreateChild.Func1.Case1
CaseCategory    IP6
CaseDescription {Test the CreateChild and Destroy Function of IP6 - Invoke CreateChild() \
                 to create two children and invoke DestroyChild() to destroy them.}
################################################################################

Include IP6/include/Ip6.inc.tcl

#
# Begin Log ...
#
BeginLog
#
# Begin Scope ...
#
BeginScope _IP6_CREATECHILD_FUNCTION1_CASE1_

#
# Parameter Definition
# R_ represents "Remote EFI Side Parameter"
# L_ represents "Local OS Side Parameter"
#
UINTN                            R_Status
UINTN                            R_Handle1
UINTN                            R_Handle2

#
# Check point: Call CreateChild to create child1.
#              EFI_SUCCESS should be returned.
#
Ip6ServiceBinding->CreateChild "&@R_Handle1, &@R_Status"
GetAck
set assert [VerifyReturnStatus R_Status $EFI_SUCCESS]
RecordAssertion $assert $Ip6CreateChildFunc1AssertionGuid001        \
                "Ip6SB.CreateChild - Func - Create Child 1"                     \
                "ReturnStatus - $R_Status, ExpectedStatus - $EFI_SUCCESS"
SetVar [subst $ENTS_CUR_CHILD]          @R_Handle1

#
# Check point: Call CreateChild to create child2.
#              EFI_SUCCESS should be returned.
#
Ip6ServiceBinding->CreateChild "&@R_Handle2, &@R_Status"
GetAck
set assert [VerifyReturnStatus R_Status $EFI_SUCCESS]
RecordAssertion $assert $Ip6CreateChildFunc1AssertionGuid002        \
                "Ip6SB.CreateChild - Func - Create Child 1"                    \
                "ReturnStatus - $R_Status, ExpectedStatus - $EFI_SUCCESS"
SetVar [subst $ENTS_CUR_CHILD]          @R_Handle2

#
# Check point: Call DestroyChild to destroy child2.
#              EFI_SUCCESS should be returned.
#
Ip6ServiceBinding->DestroyChild "@R_Handle2, &@R_Status"
GetAck
set assert [VerifyReturnStatus R_Status $EFI_SUCCESS]
RecordAssertion $assert $Ip6DestroyChildFunc1AssertionGuid001        \
                "Ip6SB.DestroyChild - Func - DestroyChild 1"                    \
                "ReturnStatus - $R_Status, ExpectedStatus - $EFI_SUCCESS"

#
# Check point: Call DestroyChild to create child1.
#              EFI_SUCCESS should be returned.
#
Ip6ServiceBinding->DestroyChild "@R_Handle1 &@R_Status"
GetAck
set assert [VerifyReturnStatus R_Status $EFI_SUCCESS]
RecordAssertion $assert $Ip6DestroyChildFunc1AssertionGuid002        \
                "Ip6SB.DestroyChild - Func - Detroy Child 1"                     \
                "ReturnStatus - $R_Status, ExpectedStatus - $EFI_SUCCESS"

#
# End Scope
#
EndScope _IP6_CREATECHILD_FUNCTION1_CASE1_
#
#End Log
#
EndLog
