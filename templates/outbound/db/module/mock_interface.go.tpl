package {{.ModuleNameLower}}

import (
	"context"
	"github.com/stretchr/testify/mock"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	"database/sql"
    "github.com/DATA-DOG/go-sqlmock"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
    "gorm.io/gorm/logger"
    "testing"
)

type Mock{{.ModuleName}}Repository struct {
	mock.Mock
}

func (m *Mock{{.ModuleName}}Repository) Create(ctx context.Context, data *model.Table{{.ModuleName}}) error {
	args := m.Called(ctx, data)
	return args.Error(0)
}

func (m *Mock{{.ModuleName}}Repository) Delete(ctx context.Context, id uint64) error {
	args := m.Called(ctx, id)
	return args.Error(0)
}

func (m *Mock{{.ModuleName}}Repository) GetByID(ctx context.Context, id uint64) (model.Table{{.ModuleName}}, error) {
	args := m.Called(ctx, id)
	return args.Get(0).(model.Table{{.ModuleName}}), args.Error(1)
}

func (m *Mock{{.ModuleName}}Repository) GetList(ctx context.Context, request model.GetList{{.ModuleName}}Request) (list []model.Table{{.ModuleName}}, count int64, err error) {
	args := m.Called(ctx, request)
	return args.Get(0).([]model.Table{{.ModuleName}}), args.Get(1).(int64), args.Error(2)
}

func (m *Mock{{.ModuleName}}Repository) Update(ctx context.Context, req model.Table{{.ModuleName}}) (model.Table{{.ModuleName}}, error) {
	args := m.Called(ctx, req)
	return args.Get(0).(model.Table{{.ModuleName}}), args.Error(1)
}

func DbMock(t *testing.T) (*sql.DB, *gorm.DB, sqlmock.Sqlmock) {
	sqldb, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	gormdb, err := gorm.Open(postgres.New(postgres.Config{
		Conn: sqldb,
	}), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})

	if err != nil {
		t.Fatal(err)
	}
	return sqldb, gormdb, mock
}