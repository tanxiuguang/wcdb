/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <WCDB/WCTDatabase+Private.h>
#import <WCDB/WCTDatabase+Transaction.h>
#import <WCDB/WCTHandle+Private.h>

@implementation WCTDatabase (Transaction)

- (BOOL)isInTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->isInTransaction();
}

- (BOOL)beginTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->beginTransaction();
}

- (BOOL)commitOrRollbackTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->commitOrRollbackTransaction();
}

- (void)rollbackTransaction
{
    WCTDatabaseAssert(return;);
    return _database->rollbackTransaction();
}

- (BOOL)runTransaction:(WCDB_NO_ESCAPE WCTTransactionBlock)inTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->runTransaction([&inTransaction, self](WCDB::Handle *handle) -> bool {
        @autoreleasepool {
            WCTHandle *transactionHandle = [[WCTHandle alloc] initWithDatabase:self];
            BOOL result = inTransaction(transactionHandle);
            [transactionHandle invalidate];
            return result;
        }
    });
}

- (BOOL)beginNestedTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->beginNestedTransaction();
}

- (BOOL)commitOrRollbackNestedTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->commitOrRollbackNestedTransaction();
}

- (void)rollbackNestedTransaction
{
    WCTDatabaseAssert(return;);
    return _database->rollbackNestedTransaction();
}

- (BOOL)runNestedTransaction:(WCDB_NO_ESCAPE WCTTransactionBlock)inTransaction
{
    WCTDatabaseAssert(return NO;);
    return _database->runNestedTransaction([&inTransaction, self](WCDB::Handle *handle) -> bool {
        @autoreleasepool {
            WCTHandle *transactionHandle = [[WCTHandle alloc] initWithDatabase:self];
            BOOL result = inTransaction(transactionHandle);
            [transactionHandle invalidate];
            return result;
        }
    });
}

@end
