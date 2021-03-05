import { DataTypes } from 'sequelize';

/**
 * Lesson database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const lesson = sequelize.define(
    'lesson',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      title: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      lesson: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      active: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      importHash: {
        type: DataTypes.STRING(255),
        allowNull: true,        
      },
    },
    {
      indexes: [
        {
          unique: true,
          fields: ['importHash', 'tenantId'],
          where: {
            deletedAt: null,
          },
        },

      ],
      timestamps: true,
      paranoid: true,
    },
  );

  lesson.associate = (models) => {
    models.lesson.belongsTo(models.chapter, {
      as: 'chapter',
      constraints: false,
    });

    models.lesson.belongsTo(models.book, {
      as: 'book',
      constraints: false,
    });


    
    models.lesson.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.lesson.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.lesson.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return lesson;
}
