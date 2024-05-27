package {{.ModuleNameLower}}

import (
	"context"
	"github.com/stretchr/testify/mock"
	"{{.ModuleNameRoot}}/internal/outbound/model"
)

type Mock{{.ModuleName}}Repository struct {
	mock.Mock
}

func (m *Mock{{.ModuleName}}Repository) Create(ctx context.Context, data *model.Table{{.ModuleName}}) error {
	args := m.Called(ctx, data)
	return args.Error(0)
}

func (m *MockTaskRepository) Delete(ctx context.Context, id uint64) error {
	args := m.Called(ctx, id)
	return args.Error(0)
}

func (m *MockTaskRepository) GetByID(ctx context.Context, id uint64) (model.TableTask, error) {
	args := m.Called(ctx, id)
	return args.Get(0).(model.TableTask), args.Error(1)
}

func (m *MockTaskRepository) GetList(ctx context.Context, request model.GetListTaskRequest) (list []model.TableTask, count int64, err error) {
	args := m.Called(ctx, request)
	return args.Get(0).([]model.TableTask), args.Get(1).(int64), args.Error(2)
}

func (m *MockTaskRepository) Update(ctx context.Context, req model.TableTask) (model.TableTask, error) {
	args := m.Called(ctx, req)
	return args.Get(0).(model.TableTask), args.Error(1)
}