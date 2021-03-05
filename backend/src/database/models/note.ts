import { DataTypes } from 'sequelize';

/**
 * Note database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const note = sequelize.define(
    'note',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      notes: {
        type: DataTypes.TEXT,
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

  note.associate = (models) => {
    models.note.belongsTo(models.lesson, {
      as: 'lesson',
      constraints: false,
    });


    
    models.note.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.note.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.note.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return note;
}
