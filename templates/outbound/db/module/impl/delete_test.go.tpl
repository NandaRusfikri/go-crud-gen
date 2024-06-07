package impl

import (
	"context"
	"errors"
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/DATA-DOG/go-sqlmock"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	rmodel "{{.ModuleNameRoot}}/pkg/resource/model"
)

func TestDelete(t *testing.T) {
	sqlDB, db, mock := {{.ModuleNameLower}}.DbMock(t)
	defer sqlDB.Close()
	implObj := New(rmodel.Database{
		Template: db,
	})

	tests := []struct {
		name         string
		id           uint64
		mockBehavior func(sqlmock.Sqlmock)
		expectedErr  error
	}{
		{
			name: "Positive case",
			id:   1,
			mockBehavior: func(mock sqlmock.Sqlmock) {
				delSQL := `UPDATE "{{.ModuleNameLower}}" SET "deleted_at"=\$1 WHERE "id"=\$2 AND "{{.ModuleNameLower}}"."deleted_at" IS NULL`
				mock.ExpectBegin()
				mock.ExpectExec(delSQL).
					WithArgs(sqlmock.AnyArg(), 1).
					WillReturnResult(sqlmock.NewResult(1, 1))
				mock.ExpectCommit()
			},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			id:   1,
			mockBehavior: func(mock sqlmock.Sqlmock) {
				delSQL := `UPDATE "{{.ModuleNameLower}}" SET "deleted_at"=\$1 WHERE "id"=\$2 AND "{{.ModuleNameLower}}"."deleted_at" IS NULL`
				mock.ExpectBegin()
				mock.ExpectExec(delSQL).
					WithArgs(sqlmock.AnyArg(), 1).
					WillReturnError(fmt.Errorf("delete failed"))
				mock.ExpectRollback()
			},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tt.mockBehavior(mock)

			err := implObj.Delete(context.Background(), tt.id)

			assert.Equal(t, tt.expectedErr, err)
			assert.Nil(t, mock.ExpectationsWereMet())
		})
	}
}
