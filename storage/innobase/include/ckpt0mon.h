#ifndef ckpt0mon_h
#define ckpt0mon_h

#include <string>
#include <stdint.h>
#include "ut0rbt.h"

// TPC-C table space_id
enum tpcc_table_name_t{
  WAREHOUSE = 0,
  STOCK,
  ITEM,
  DISTRICT,
  CUSTOMER,
  ORDERS,
  NEW_ORDERS,
  HISTORY,
  ORDER_LINE
};

extern ulint tpcc_space_ids[ORDER_LINE + 1];

void ckpt_set_space_id_for_tpcc(char* fname, ulint space_id);
void ckpt_add_write_type(ulint space_id, uint8_t flush_type);

#endif
