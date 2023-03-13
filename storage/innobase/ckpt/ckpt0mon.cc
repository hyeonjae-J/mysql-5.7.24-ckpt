#include "ckpt0mon.h"
#include "srv0srv.h"
#include "ut0rbt.h"

// TPC-C table space_id
ulint tpcc_space_ids[ORDER_LINE + 1] = {0,};

void ckpt_set_space_id_for_tpcc(char* fname, ulint space_id) {
  if (strcmp(fname, "./tpcc/warehouse.ibd") == 0) {
    tpcc_space_ids[WAREHOUSE] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/stock.ibd") == 0) {
    tpcc_space_ids[STOCK] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/item.ibd") == 0) {
    tpcc_space_ids[ITEM] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/district.ibd") == 0) {
    tpcc_space_ids[DISTRICT] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/customer.ibd") == 0) {
    tpcc_space_ids[CUSTOMER] = space_id;
  }
  else if (strcmp(fname, "./tpcc/orders.ibd") == 0) {
    tpcc_space_ids[ORDERS] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/new_orders.ibd") == 0) {
    tpcc_space_ids[NEW_ORDERS] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/history.ibd") == 0) {
    tpcc_space_ids[HISTORY] = space_id;
  } 
  else if (strcmp(fname, "./tpcc/order_line.ibd") == 0) {
    tpcc_space_ids[ORDER_LINE] = space_id;
  }

  fprintf(stderr, "TPC-C Table %s to %lu\n", fname, space_id);
}


void ckpt_add_write_type(ulint space_id, uint8_t flush_type) {
  // TODO(jhpark): make it macro!

  if (space_id == tpcc_space_ids[WAREHOUSE]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_wh_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_wh_ckpt.inc() 
       : srv_stats.tpcc_wh_spf.inc() );
  } 
  else if (space_id == tpcc_space_ids[STOCK]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_st_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_st_ckpt.inc() 
       : srv_stats.tpcc_st_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[ITEM]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_it_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_it_ckpt.inc() 
       : srv_stats.tpcc_it_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[DISTRICT]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_di_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_di_ckpt.inc() 
       : srv_stats.tpcc_di_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[CUSTOMER]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_cu_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_cu_ckpt.inc() 
       : srv_stats.tpcc_cu_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[ORDERS]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_od_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_od_ckpt.inc() 
       : srv_stats.tpcc_od_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[NEW_ORDERS]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_no_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_no_ckpt.inc() 
       : srv_stats.tpcc_no_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[HISTORY]) {
    (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_hi_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_hi_ckpt.inc() 
       : srv_stats.tpcc_hi_spf.inc() );

  } 
  else if (space_id == tpcc_space_ids[ORDER_LINE]) {
     (flush_type == BUF_FLUSH_LRU) ? srv_stats.tpcc_ol_lru.inc() : 
      ((flush_type == BUF_FLUSH_LIST)? srv_stats.tpcc_ol_ckpt.inc() 
       : srv_stats.tpcc_ol_spf.inc() );
  }
}
