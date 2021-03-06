#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
# Copyright (c) 1996, 2018, Oracle and/or its affiliates. All rights reserved.
#

# Common method file for *.UTF-8.


METHODS

#
# As of 10/18/2000, we need to set the 'process_code' to 'euc' unfortunately
# to make localedef(1) happy. We trick the localedef(1) this way and use
# UTF-32 as our wide character code/representation and 'Dense UTF-32' as
# our "native" and or locale data access code. Detail on these two
# process codes and their conversions are described in the mb.c, pcwc.h, and
# the Invention Disclosure ID P5631.
#
file_code	utf8
process_code	ucs4


#
# We use the following methods from the libc.
#
iswctype@native	"__iswctype_std"        "libc" "/usr/lib/" "/usr/lib/" "libc.so.1"
towctrans@native "__towctrans_std"
towlower@native	"__towlower_std"
towupper@native "__towupper_std"
trwctype        "__trwctype_std"
wctrans         "__wctrans_std"
wctype          "__wctype_std"

mbsinit		"__mbsinit_gen"
mbrlen		"__mbrlen_gen"
 
strcoll         "__strcoll_std"
strxfrm         "__strxfrm_std"
wcscoll         "__wcscoll_bc"
wcscoll@native  "__wcscoll_std"
wcsxfrm         "__wcsxfrm_bc"
wcsxfrm@native  "__wcsxfrm_std"

fnmatch         "__fnmatch_std"
regcomp         "__regcomp_std"
regexec         "__regexec_std"
regerror        "__regerror_std"
regfree         "__regfree_std"

strfmon         "__strfmon_std"

strftime        "__strftime_std"
strptime        "__strptime_std"
wcsftime        "__wcsftime_std"

getdate         "__getdate_std"

#
# The methods designated at below are all Unicode locale-specific methods
# coming from the methods_unicode.so.3 common shared object.
#
eucpctowc	"__u32_to_dense_u32_utf8"	"localelib" "/usr/lib/locale/common/" "/usr/lib/locale/common/" "methods_unicode.so.3"
wctoeucpc	"__dense_u32_to_u32_utf8"

iswctype        "__iswctype_bc_utf8"
towctrans       "__towctrans_bc_utf8"
towlower        "__towlower_bc_utf8"
towupper        "__towupper_bc_utf8"

mbftowc		"__mbftowc_dense_utf8"
mbftowc@native	"__mbftowc_dense_native_utf8"
fgetwc		"__fgetwc_dense_utf8"
fgetwc@native	"__fgetwc_dense_native_utf8"
mblen		"__mblen_dense_utf8"
mbstowcs	"__mbstowcs_dense_utf8"
mbstowcs@native	"__mbstowcs_dense_native_utf8"
mbtowc		"__mbtowc_dense_utf8"
mbtowc@native	"__mbtowc_dense_native_utf8"
wcstombs	"__wcstombs_dense_utf8"
wcstombs@native	"__wcstombs_dense_native_utf8"
wcswidth	"__wcswidth_dense_utf8"
wcswidth@native	"__wcswidth_dense_utf8"
wctomb		"__wctomb_dense_utf8"
wctomb@native	"__wctomb_dense_native_utf8"
wcwidth		"__wcwidth_dense_utf8"
wcwidth@native	"__wcwidth_dense_utf8"
#
# To workaround a problem in the current localedef(1) of 2.7/MSE, we need to
# define both <method> and <method@native> designations even for dense
# encoding locale like UTF-8 locale.
#
btowc		"__btowc_dense_utf8"
btowc@native	"__btowc_dense_utf8"
wctob		"__wctob_dense_utf8"
wctob@native	"__wctob_dense_utf8"
mbrtowc		"__mbrtowc_dense_utf8"
mbrtowc@native	"__mbrtowc_dense_native_utf8"
wcrtomb		"__wcrtomb_dense_utf8"
wcrtomb@native	"__wcrtomb_dense_native_utf8"
mbsrtowcs	"__mbsrtowcs_dense_utf8"
mbsrtowcs@native "__mbsrtowcs_dense_native_utf8"
wcsrtombs	"__wcsrtombs_dense_utf8"
wcsrtombs@native "__wcsrtombs_dense_native_utf8"

END METHODS
