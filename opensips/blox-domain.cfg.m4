route[BLOX_DOMAIN] {
    $var(uuid) = "DOM" + $param(1) + ":" + $rd ;
    $avp(DEFURI) = "";    
    if(cache_fetch("local","$var(uuid)",$avp(DEFURI))) {
        xdbg("Loaded from cache $var(uuid): $avp(DEFURI)\n");
    } else if (avp_db_load("$var(uuid)","$avp(DEFURI)/blox_domain")) {
        cache_store("local","$var(uuid)","$avp(DEFURI)");
        xdbg("Stored in cache $var(uuid): $avp(DEFURI)\n");
    } else {
        $avp(DEFURI) = null;
        xlog("L_WARN", "BLOX_DBG::: $rm METHOD Domain name not configured in blox for $var(uuid)\n" );
	drop();
	return 0;
    }

    $du = $avp(DEFURI) ;
    xlog("L_WARN", "BLOX_DBG::: Domain name $var(uuid) routed to $avp(DEFURI) \n");
}
